from flask import Blueprint, redirect, render_template, session, url_for

from app.utils.security import login_required

home = Blueprint("home", __name__)

@home.route("/")
def index():
    if "user_id" in session:
        return redirect(url_for("home.dashboard"))
    return redirect(url_for("user.login"))

@home.route("/dashboard")
@login_required
def dashboard():
    from app.service import book_service, inbox_service, lending_service

    user_id = session["user_id"]
    collection = book_service.get_user_collection(user_id)
    lendings = lending_service.get_user_lendings(user_id)
    incoming = lending_service.get_incoming_requests(user_id)
    unread = inbox_service.get_unread_count(user_id)
    return render_template(
        "dashboard.html",
        collection=collection,
        lendings=lendings,
        incoming=incoming,
        unread=unread,
    )
