class SitemapController < ApplicationController
  layout nil

  def index
    headers['Content-Type'] = 'application/xml'
    last_post = Post.last
    last_product = Producto.last
    if stale?(:etag => last_post, :last_modified => last_post.updated_at.utc) || stale?(:etag => last_product, :last_modified => last_product.updated_at.utc)
      respond_to do |format|
        format.xml {
          @posts = Post.all
          @products = Producto.all
        }
      end
    end
  end
end