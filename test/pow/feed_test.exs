defmodule Pow.FeedTest do
  use Pow.DataCase

  alias Pow.Feed

  describe "posts" do
    alias Pow.Feed.Post

    @valid_attrs %{title: "some title", url: "some url"}
    @update_attrs %{title: "some updated title", url: "some updated url"}
    @invalid_attrs %{title: nil, url: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Feed.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Feed.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Feed.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Feed.create_post(@valid_attrs)
      assert post.title == "some title"
      assert post.url == "some url"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feed.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Feed.update_post(post, @update_attrs)
      assert post.title == "some updated title"
      assert post.url == "some updated url"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Feed.update_post(post, @invalid_attrs)
      assert post == Feed.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Feed.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Feed.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Feed.change_post(post)
    end
  end

  describe "upvotes" do
    alias Pow.Feed.Upvote

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def upvote_fixture(attrs \\ %{}) do
      {:ok, upvote} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Feed.create_upvote()

      upvote
    end

    test "list_upvotes/0 returns all upvotes" do
      upvote = upvote_fixture()
      assert Feed.list_upvotes() == [upvote]
    end

    test "get_upvote!/1 returns the upvote with given id" do
      upvote = upvote_fixture()
      assert Feed.get_upvote!(upvote.id) == upvote
    end

    test "create_upvote/1 with valid data creates a upvote" do
      assert {:ok, %Upvote{} = upvote} = Feed.create_upvote(@valid_attrs)
    end

    test "create_upvote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feed.create_upvote(@invalid_attrs)
    end

    test "update_upvote/2 with valid data updates the upvote" do
      upvote = upvote_fixture()
      assert {:ok, %Upvote{} = upvote} = Feed.update_upvote(upvote, @update_attrs)
    end

    test "update_upvote/2 with invalid data returns error changeset" do
      upvote = upvote_fixture()
      assert {:error, %Ecto.Changeset{}} = Feed.update_upvote(upvote, @invalid_attrs)
      assert upvote == Feed.get_upvote!(upvote.id)
    end

    test "delete_upvote/1 deletes the upvote" do
      upvote = upvote_fixture()
      assert {:ok, %Upvote{}} = Feed.delete_upvote(upvote)
      assert_raise Ecto.NoResultsError, fn -> Feed.get_upvote!(upvote.id) end
    end

    test "change_upvote/1 returns a upvote changeset" do
      upvote = upvote_fixture()
      assert %Ecto.Changeset{} = Feed.change_upvote(upvote)
    end
  end
end
