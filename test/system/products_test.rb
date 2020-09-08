require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "creating a Product" do
    visit products_url
    click_on "New Product"

    fill_in "Img path", with: @product.img_path
    fill_in "Info", with: @product.info
    fill_in "Title", with: @product.title
    fill_in "Value", with: @product.value
    click_on "Create Product"

    assert_text "Product was successfully created"
  end

  test "updating a Product" do
    visit products_url
    click_on "Edit", match: :first

    fill_in "Img path", with: @product.img_path
    fill_in "Info", with: @product.info
    fill_in "Title", with: @product.title
    fill_in "Value", with: @product.value
    click_on "Update Product"

    assert_text "Product was successfully updated"
  end

  test "destroying a Product" do
    visit products_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product was successfully destroyed"
  end
end
