defmodule ShowcaseWeb.UserTest do
  use ShowcaseWeb.DataCase

  alias Showcase.User

  @valid_attrs %{email: "email@email", name: "some name"}
  @invalid_attrs %{email: nil, name: nil}
  @invalid_email_attrs %{email: "emailemail", name: "some name"}

  test "valid data creates a user" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "invalid data creates a user" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "invalid email creates a user" do
    changeset = User.changeset(%User{}, @invalid_email_attrs)
    assert %{email: ["has invalid format"]} = errors_on(changeset)
  end

end