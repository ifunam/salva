class DocumentsController < ApplicationController
    respond_to :xml

    def destroy
      @document = Document.find(params[:id])
      @document.destroy
      respond_with(@document)
    end
end
