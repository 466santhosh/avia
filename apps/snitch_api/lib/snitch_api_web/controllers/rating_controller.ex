defmodule SnitchApiWeb.RatingController do
  use SnitchApiWeb, :controller

  alias Snitch.Data.Model.Rating
  alias Snitch.Repo

  plug(SnitchApiWeb.Plug.DataToAttributes)

  def index(conn, _params) do
    ratings = Rating.get_all()
    render(conn, "index.json-api", data: ratings)
  end

  def show(conn, %{"id" => rating_id}) do
    rating =
      rating_id
      |> String.to_integer()
      |> Rating.get()
      |> Repo.preload(:rating_options)

    render(
      conn,
      "show.json-api",
      data: rating,
      opts: [include: "rating_options"]
    )
  end
end
