module  ActionView
  module Layouts
    class Application < Minimal::Template

      def content
        html do
          body do
            header
            topbar
            navbar
            main_content
            footer
          end
        end
      end

      def header
        div :id => 'header' do
          h1 'SALVA - Plataforma de Información Curricular'
        end
      end

      def topbar
        div :id => 'topbar' do
        end
      end

      def navbar
        div :id => 'navbar' do
        end
      end

      # Override this
      def main_content
        div :id => 'main_container' do 
        end
      end

      def footer
        div :id => 'footer' do
        end
      end

    end
  end
end