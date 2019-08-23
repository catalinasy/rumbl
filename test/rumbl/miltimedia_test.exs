defmodule Rumbl.MiltimediaTest do
  use Rumbl.DataCase

  alias Rumbl.Miltimedia

  describe "videos" do
    alias Rumbl.Miltimedia.Video

    @valid_attrs %{" url": "some  url", description: "some description", title: "some title"}
    @update_attrs %{" url": "some updated  url", description: "some updated description", title: "some updated title"}
    @invalid_attrs %{" url": nil, description: nil, title: nil}

    def video_fixture(attrs \\ %{}) do
      {:ok, video} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Miltimedia.create_video()

      video
    end

    test "list_videos/0 returns all videos" do
      video = video_fixture()
      assert Miltimedia.list_videos() == [video]
    end

    test "get_video!/1 returns the video with given id" do
      video = video_fixture()
      assert Miltimedia.get_video!(video.id) == video
    end

    test "create_video/1 with valid data creates a video" do
      assert {:ok, %Video{} = video} = Miltimedia.create_video(@valid_attrs)
      assert video. url == "some  url"
      assert video.description == "some description"
      assert video.title == "some title"
    end

    test "create_video/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Miltimedia.create_video(@invalid_attrs)
    end

    test "update_video/2 with valid data updates the video" do
      video = video_fixture()
      assert {:ok, %Video{} = video} = Miltimedia.update_video(video, @update_attrs)
      assert video. url == "some updated  url"
      assert video.description == "some updated description"
      assert video.title == "some updated title"
    end

    test "update_video/2 with invalid data returns error changeset" do
      video = video_fixture()
      assert {:error, %Ecto.Changeset{}} = Miltimedia.update_video(video, @invalid_attrs)
      assert video == Miltimedia.get_video!(video.id)
    end

    test "delete_video/1 deletes the video" do
      video = video_fixture()
      assert {:ok, %Video{}} = Miltimedia.delete_video(video)
      assert_raise Ecto.NoResultsError, fn -> Miltimedia.get_video!(video.id) end
    end

    test "change_video/1 returns a video changeset" do
      video = video_fixture()
      assert %Ecto.Changeset{} = Miltimedia.change_video(video)
    end
  end
end
