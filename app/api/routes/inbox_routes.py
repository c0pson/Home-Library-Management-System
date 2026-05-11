from flask import Blueprint, redirect, render_template, session, url_for

from app.service import inbox_service
from app.utils.security import login_required

inbox = Blueprint("inbox", __name__, url_prefix="/inbox")

@inbox.route("/")
@login_required
def index():
    messages = inbox_service.get_inbox(session["user_id"])
    return render_template("inbox.html", messages=messages)

@inbox.route("/<int:message_id>/read", methods=["POST"])
@login_required
def mark_read(message_id):
    inbox_service.mark_read(message_id, session["user_id"])
    return redirect(url_for("inbox.index"))
