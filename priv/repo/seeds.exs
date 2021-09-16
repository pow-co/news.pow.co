# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs

alias Pow.{Feed, Accounts, DistanceOfTimeHelpers}

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
  %{title: "Show HN: Time Travel Debugger", url: "https://www.replay.io", creator_id: Enum.at(users, 0).id, inserted_at: DistanceOfTimeHelpers.random_days_ago(1..15)},
  %{title: "Username ending with MIME type format is not allowed", url: "https://gitlab.com/gitlab-org/gitlab/-/issues/335278", creator_id: Enum.at(users, 1).id, inserted_at: DistanceOfTimeHelpers.random_days_ago(1..15)},
  %{title: "The Best of Scribblers: Edward Gibbon (2015)", url: "https://www.commentary.org/articles/joseph-epstein/best-scribblers/", creator_id: Enum.at(users, 2).id, inserted_at: DistanceOfTimeHelpers.random_days_ago(1..15)},
  %{title: "FreeBSD SSH Hardening", url: "https://gist.github.com/koobs/e01cf8869484a095605404cd0051eb11", creator_id: Enum.at(users, 3).id, inserted_at: DistanceOfTimeHelpers.random_days_ago(1..15)},
  %{title: "Why Don't Rich People Just Stop Working?", url: "https://journal.media/why-don-t-rich-people-just-stop-working", creator_id: Enum.at(users, 4).id, inserted_at: DistanceOfTimeHelpers.random_days_ago(1..15)},
  %{title: "Turing Oversold?", url: "https://people.idsia.ch//~juergen/turing-oversold.html", creator_id: Enum.at(users, 5).id, inserted_at: DistanceOfTimeHelpers.random_days_ago(1..15)},
  %{title: "Nuclear Pasta", url: "https://en.wikipedia.org/wiki/Nuclear_pasta", creator_id: Enum.at(users, 5).id, inserted_at: DistanceOfTimeHelpers.random_days_ago(1..15)},
  %{title: "Podman: The Missing Tutorial", url: "https://shekhargulati.com/2021/09/16/podman-the-missing-tutorial/", creator_id: Enum.at(users, 5).id, inserted_at: DistanceOfTimeHelpers.random_days_ago(1..15)},
  %{title: "How to Write a Spelling Corrector", url: "https://norvig.com/spell-correct.html", creator_id: Enum.at(users, 5).id, inserted_at: DistanceOfTimeHelpers.random_days_ago(1..15)},
  %{title: "CVE-2016-20012 – Publickey Information leak", url: "https://github.com/openssh/openssh-portable/pull/270", creator_id: Enum.at(users, 5).id, inserted_at: DistanceOfTimeHelpers.random_days_ago(1..15)},
  %{title: "Is github.com (the website) slow to anyone else?", url: "https://news.ycombinator.com/item?id=28551396", creator_id: Enum.at(users, 5).id, inserted_at: DistanceOfTimeHelpers.random_days_ago(1..15)},
  %{title: "Margin Accounts at Brokers and Dealers hits highest-ever levels", url: "https://fred.stlouisfed.org/series/BOGZ1FL663067003Q", creator_id: Enum.at(users, 5).id, inserted_at: DistanceOfTimeHelpers.random_days_ago(1..15)},
  %{title: "5 Tips for writing production-ready Celery tasks", url: "https://blog.wolt.com/engineering/2021/09/15/5-tips-for-writing-production-ready-celery-tasks/", creator_id: Enum.at(users, 5).id, inserted_at: DistanceOfTimeHelpers.random_days_ago(1..15)},
  %{title: "Job: Assistant Professor of Information Security", url: "https://jobs.utoronto.ca/job/Toronto-Assistant-Professor-Information-Security-ON/550439517/", creator_id: Enum.at(users, 5).id, inserted_at: DistanceOfTimeHelpers.random_days_ago(1..15)},
  %{title: "The Cloudflare Backbone", url: "https://blog.cloudflare.com/cloudflare-backbone-internet-fast-lane/", creator_id: Enum.at(users, 5).id, inserted_at: DistanceOfTimeHelpers.random_days_ago(1..15)},
  %{title: "How Amazon Web Services makes money: Estimated margins by service", url: "https://www.cnbc.com/2021/09/05/how-amazon-web-services-makes-money-estimated-margins-by-service.html", creator_id: Enum.at(users, 5).id, inserted_at: DistanceOfTimeHelpers.random_days_ago(1..15)},
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




