defmodule RumblWeb.VideoController do
  use RumblWeb, :controller

  alias Rumbl.Miltimedia
  alias Rumbl.Miltimedia.Video

  def index(conn, _params) do
    videos = Miltimedia.list_videos()
    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params) do
    changeset = Miltimedia.change_video(%Video{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}) do
    case Miltimedia.create_video(video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: Routes.video_path(conn, :show, video))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    video = Miltimedia.get_video!(id)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}) do
    video = Miltimedia.get_video!(id)
    changeset = Miltimedia.change_video(video)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Miltimedia.get_video!(id)

    case Miltimedia.update_video(video, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: Routes.video_path(conn, :show, video))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    video = Miltimedia.get_video!(id)
    {:ok, _video} = Miltimedia.delete_video(video)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: Routes.video_path(conn, :index))
  end
end
