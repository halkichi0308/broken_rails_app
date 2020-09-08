#module Admin
class Admin::ProductsController < Admin::ApplicationController

  #class ProductsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Product.
    #     page(params[:page]).
    #     per(10)
    # end
    # def find_resource(param)
    #   Product.find_by!(slug: param)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Product.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  #end

  # POST /admin/products/upload
  # Only Admin User
  def upload
    xml = params[:fileupload][:file]
    doc = Nokogiri::XML(xml) do |config|
      config.noent
    end    

    products = []

    def get_contents(xml_NodeSet)
      contents = {}
      begin
        xml_NodeSet.element_children.each do |node|
          contents[node.name] = node.content
        end
        return contents
      rescue => err
        return redirect_to new_admin_product_url, notice: 'Product uploads faild.'
        return err
      end
    end

    ary = doc.xpath('/product')
    
    ary.each do |xml_Node|
      products.push get_contents(xml_Node)
    end
    begin
      products.each do|product_content|
        product = Product.new
        product_content.each do |key, value|
          product[key.to_sym] = value
        end
        product.save
        return redirect_to new_admin_product_url, notice: 'Product uploads success.'
      end
    rescue => err
      return redirect_to new_admin_product_url, notice: 'Product uploads faild.'
    end
  end
end
