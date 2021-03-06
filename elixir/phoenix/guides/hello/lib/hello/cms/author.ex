defmodule Hello.CMS.Author do
  use Ecto.Schema
  import Ecto.Changeset

  alias Hello.CMS.{Author, Page}

  schema "authors" do
    field :bio, :string
    field :genre, :string
    field :role, :string

    belongs_to :user, Hello.Accounts.User
    has_many :pages, Page

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:bio, :role, :genre])
    |> validate_required([:bio, :role, :genre])
    |> unique_constraint(:user_id)
  end
end
