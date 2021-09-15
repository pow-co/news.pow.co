# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs

alias Pow.{Feed, Accounts}

users = [
  %{username: "jasonlaster11", about: "world is turning around"},
  %{username: "anielsen", about: "Living in the crazy world"},
  %{username: "linkdd", about: "world is turning around"},
  %{username: "tdido", about: "Founder/CEO Pipedream.com. Also #girldad, investor & lifelong learner."},
  %{username: "mattashii", about: "Living in the crazy world"},
  %{username: "jasonlaster11", about: "Lead [Cloud] Infrastructure @ Cofano Software Solutions"}
]

Enum.each(users, &Accounts.create_user/1)
users = Accounts.list_users()

posts = [
  %{title: "Show HN: Time Travel Debugger", url: "https://www.replay.io", creator_id: Enum.at(users, 0).id},
  %{title: "Username ending with MIME type format is not allowed", url: "https://gitlab.com/gitlab-org/gitlab/-/issues/335278", creator_id: Enum.at(users, 1).id},
  %{title: "The Best of Scribblers: Edward Gibbon (2015)", url: "https://www.commentary.org/articles/joseph-epstein/best-scribblers/", creator_id: Enum.at(users, 2).id},
  %{title: "FreeBSD SSH Hardening", url: "https://gist.github.com/koobs/e01cf8869484a095605404cd0051eb11", creator_id: Enum.at(users, 3).id},
  %{title: "Why Don't Rich People Just Stop Working?", url: "https://journal.media/why-don-t-rich-people-just-stop-working", creator_id: Enum.at(users, 4).id},
  %{title: "Turing Oversold?", url: "https://people.idsia.ch//~juergen/turing-oversold.html", creator_id: Enum.at(users, 5).id}
]

Enum.each(posts, &Feed.create_post/1)
posts = Feed.list_posts()

# Randomly create upvotes

Enum.each(posts, fn post ->
  n = Enum.random(1..50)

  Enum.each(0..n, fn _n ->
    user = Enum.random(users)
    Feed.create_upvote(%{post_id: post.id, user_id: user.id})
  end)
end)
