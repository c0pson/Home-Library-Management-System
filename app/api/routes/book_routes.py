from flask import Blueprint, redirect, render_template, request, session, url_for

from app.api.schemas import book_schema
from app.service import book_service
from app.utils.security import login_required

books = Blueprint("books", __name__, url_prefix="/books")

@books.route("/")
@login_required
def index():
    search = request.args.get("q", "").strip()
    sort_by = request.args.get("sort", "title")
    all_books = book_service.get_all_books(search=search, sort_by=sort_by)
    return render_template("books.html", books=all_books, search=search, sort_by=sort_by)

@books.route("/browse")
@login_required
def browse():
    """Books available for borrowing from other users' collections."""
    available = book_service.get_available_books()
    user_id = session["user_id"]
    available = [b for b in available if b["user_id"] != user_id]
    return render_template("browse.html", available=available)

@books.route("/add", methods=["GET", "POST"])
@login_required
def add():
    errors, data = {}, {}
    if request.method == "POST":
        data = request.form.to_dict()
        errors = book_schema.validate_book(data)
        if not errors:
            book = book_service.create_book(data)
            book_service.add_to_collection(
                session["user_id"], book.book_id, data.get("condition")
            )
            return redirect(url_for("books.collection"))
    return render_template("book_add.html", errors=errors, data=data)

@books.route("/collection")
@login_required
def collection():
    items = book_service.get_user_collection(session["user_id"])
    return render_template("collection.html", items=items)

@books.route("/collection/remove/<int:collection_id>", methods=["POST"])
@login_required
def remove_from_collection(collection_id):
    book_service.remove_from_collection(collection_id, session["user_id"])
    return redirect(url_for("books.collection"))
