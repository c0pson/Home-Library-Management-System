from flask import Blueprint, redirect, render_template, request, session, url_for

from app.api.schemas import user_schema
from app.service import user_service
from app.utils.security import login_required

user = Blueprint("user", __name__)

@user.route("/login", methods=["GET", "POST"])
def login():
    if "user_id" in session:
        return redirect(url_for("home.dashboard"))
    errors, error, data = {}, None, {}
    if request.method == "POST":
        data = request.form.to_dict()
        errors = user_schema.validate_login(data)
        if not errors:
            u, error = user_service.login(data["username"], data["password"])
            if u:
                session["user_id"] = u.user_id
                session["username"] = u.username
                return redirect(url_for("home.dashboard"))
    return render_template("login.html", errors=errors, error=error, data=data)

@user.route("/register", methods=["GET", "POST"])
def register():
    if "user_id" in session:
        return redirect(url_for("home.dashboard"))
    errors, error, data = {}, None, {}
    if request.method == "POST":
        data = request.form.to_dict()
        errors = user_schema.validate_register(data)
        if not errors:
            u, error = user_service.register(data["username"], data["password"])
            if u:
                session["user_id"] = u.user_id
                session["username"] = u.username
                return redirect(url_for("home.dashboard"))
    return render_template("register.html", errors=errors, error=error, data=data)

@user.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("user.login"))

@user.route("/friends")
@login_required
def friends():
    user_id = session["user_id"]
    query = request.args.get("q", "").strip()
    friends_list = user_service.get_friends(user_id)
    search_results = user_service.search_users(query) if query else []
    # exclude self and existing friends from search results
    friend_ids = {f.user_id for f in friends_list} | {user_id}
    search_results = [u for u in search_results if u.user_id not in friend_ids]
    return render_template(
        "friends.html",
        friends=friends_list,
        search_results=search_results,
        query=query,
    )

@user.route("/friends/add/<int:friend_id>", methods=["POST"])
@login_required
def add_friend(friend_id):
    user_service.add_friend(session["user_id"], friend_id)
    return redirect(url_for("user.friends"))

@user.route("/friends/remove/<int:friend_id>", methods=["POST"])
@login_required
def remove_friend(friend_id):
    user_service.remove_friend(session["user_id"], friend_id)
    return redirect(url_for("user.friends"))
