from flask import Blueprint, redirect, render_template, session, url_for

from app.service import lending_service
from app.utils.security import login_required

lending = Blueprint("lending", __name__, url_prefix="/lending")

@lending.route("/")
@login_required
def index():
    user_id = session["user_id"]
    my_lendings = lending_service.get_user_lendings(user_id)
    incoming = lending_service.get_incoming_requests(user_id)
    return render_template("lending.html", my_lendings=my_lendings, incoming=incoming)

@lending.route("/reserve/<int:collection_id>", methods=["POST"])
@login_required
def reserve(collection_id):
    lending_service.reserve_book(session["user_id"], collection_id)
    return redirect(url_for("books.browse"))

@lending.route("/confirm/<int:lending_id>", methods=["POST"])
@login_required
def confirm(lending_id):
    lending_service.confirm_lending(lending_id, session["user_id"])
    return redirect(url_for("lending.index"))

@lending.route("/decline/<int:lending_id>", methods=["POST"])
@login_required
def decline(lending_id):
    lending_service.decline_lending(lending_id, session["user_id"])
    return redirect(url_for("lending.index"))

@lending.route("/return/<int:lending_id>", methods=["POST"])
@login_required
def return_book(lending_id):
    lending_service.request_return(lending_id, session["user_id"])
    return redirect(url_for("lending.index"))
