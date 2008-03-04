require File.dirname(__FILE__) + '/../test_helper'
require 'model_serialize'
class ModelSerializeTest < Test::Unit::TestCase
  fixtures  :roleinconferences, :roleinconferencetalks, :userstatuses, :users, :countries, :conferencetypes, :conferencescopes, :talkacceptances, :modalities, :talktypes, :conferences, :conferencetalks, :user_conferencetalks

  def setup
    @models = [ UserConferencetalk, [Conferencetalk, [Conference, Conferencescope] ]]
    @myparams = {
      :conferencetalk =>  {
        :title =>  'Estudios sobre formacion de barrancos en la Luna',
        :authors =>  'José Arcadio Buendía y Melquiades (alias el gitano)',
        :conference_id => 1,
        :talktype_id  => 2,
        :talkacceptance_id => 1,
        :modality_id => 1,
        :conference_id => 1
      },
      :conference => {
        :name => 'Congreso Anual de Ciencias Oscuras y Magia Negra',
        :year => 2007,
        :country_id => 484,
       :conferencetype_id => 1
      },
      :conferencescope => { :name => 'Intergálactico'},
      :user_conferencetalk =>  { :roleinconferencetalk_id => 1, :user_id => 1}
    }
  end

   def test_initialize
     @record = ModelSerialize.new(@models)
     assert_kind_of Hash,  @record.records
     @models.flatten.each do |model|
       assert @record.records.has_key?(Inflector.underscore(model).singularize.to_sym)
     end
   end

   def test_fill
     @record = ModelSerialize.new(@models)
     @record.fill(@myparams)
     assert_instance_of UserConferencetalk, @record.model
     assert_instance_of Conferencetalk, @record.model.conferencetalk
     assert_instance_of Conference, @record.model.conferencetalk.conference
     assert @record.valid?
     assert @record.save
     assert_equal 3, @record.id
   end

    def test_fill_from_record
        models = *@models
        @record = ModelSerialize.new(@models)
        @record.fill(@myparams)
        assert @record.valid?
        assert @record.save

        @record = ModelSerialize.new([ UserConferencetalk, [Conferencetalk, [Conference, Conferencescope] ]], 3)
        assert_instance_of UserConferencetalk, @record.records[:user_conferencetalk]
        assert_instance_of Conferencetalk, @record.records[:conferencetalk]
        assert_equal 'Estudios sobre formacion de barrancos en la Luna', @record.records[:conferencetalk].title
        assert_instance_of Conference, @record.records[:conference]
        assert_equal 'Congreso Anual de Ciencias Oscuras y Magia Negra', @record.records[:conference].name
        assert_instance_of Conferencescope, @record.records[:conferencescope]
   end

   def test_update
        @record = ModelSerialize.new(@models)
        @record.fill(@myparams)
        assert @record.valid?
        assert @record.save

        @record = ModelSerialize.new([ UserConferencetalk, [Conferencetalk, [Conference, Conferencescope] ]], 3)
        puts @record.klasses.last
        params = {
          :conferencetalk =>  {
            :title =>  'Estudios sobre formacion de barrancos en la Luna'.reverse,
            :authors =>  'Jose Arcadio Buendia y Melquiades (alias el gitano)'.reverse,
            :conference_id => 1,
            :talktype_id  => 2,
            :talkacceptance_id => 1,
            :modality_id => 1,
            :conference_id => 1
          },
          :conference => {
            :name => 'Congreso Anual de Ciencias Oscuras y Magia Negra',
            :year => 2007,
            :country_id => 484,
           :conferencetype_id => 1
          },
          :conferencescope => { :name => 'Intergalactico'},
          :user_conferencetalk =>  { :roleinconferencetalk_id => 1, :user_id => 1}
        }
        @record.fill(params)
        assert @record.valid?
        assert @record.update_models
        @record = ModelSerialize.new([ UserConferencetalk, [Conferencetalk, [Conference, Conferencescope] ]], 3)
        puts @record.records[:conferencetalk].title
      end

   def test_fill_complex_models
#         params ={
#          :regularcourse=>{"title"=>"saasaassasa",
#          "semester"=>"2",
#          "modality_id"=>"1"},
#          "commit"=>"Guardar",
#          :institution=>{"name"=>"22222",
#          "country_id"=>"484",
#          "institutiontitle_id"=>"1",
#          "institutiontype_id"=>"1"},
#          :user_regularcourse=>{"period_id"=>"11",
#          "hoursxweek"=>"2",
#          "roleinregularcourse_id"=>"1"},
#          :academicprogram=>{"academicprogramtype_id"=>"1",
#          "year"=>"2007"},
#          :career=>{"name"=>"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
#          "degree_id"=>"6" }
#        }
#        @record = ModelSerialize.new([ UserRegularcourse, [ Regularcourse, [Academicprogram, [Institutioncareer, Institution, Career]]]])
#        @record.fill(params)
#        assert @record.valid?
#       assert @record.save

     # params = {
     #   :newspaperarticle =>{
     #     "newspaper_id"=>"2",
     #     "title"=>"asaasas",
     #     "url"=>"saassa",
     #     "authors"=>"sasasasa",
     #     "pages"=>"sasasa",
     #     "newsdate"=>"2008/01/13"},
     #   :user_newspaperarticle=>{"ismainauthor"=>"true"}
     # }
     # @record = ModelSerialize.new([UserNewspaperarticle, Newspaperarticle ])
     # @record.user_id = 1
     # @record.fill(params)
     # assert @record.model.newspaperarticle.valid?
     # assert @record.save
     # puts @record.id
     # @record = ModelSerialize.new([UserNewspaperarticle, Newspaperarticle], 8)
     
     params = {
       :genericwork=>{"genericworkstatus_id"=>"3",
      "reference"=>"",
      "month"=>"12",
      "genericworktype_id"=>"7",
      "title"=>"The Qweak experiment: A Search for New Physics at the TeV Scale via a Measurement of the Proton's Weak Charge",
      "year"=>"2007",
      "authors"=>"D.S. Armstrong et al."},
      "commit"=>"Guardar",
      "id"=>"37",
      :user_genericwork=>{"userrole_id"=>"1"}
    }
    
      @record = ModelSerialize.new([ UserGenericwork, Genericwork ])
      @record.user_id = 1
      @record.fill(params)
      assert @record.model.genericwork.valid?
      assert @record.save
      @record = ModelSerialize.new([ UserGenericwork, Genericwork], @record.id)
      assert @record.model.genericwork.valid?
      params = {
         :genericwork=>{"genericworkstatus_id"=>"3",
        "reference"=>"",
        "month"=>"12",
        "genericworktype_id"=>"7",
        "title"=>"XXXX",
        "year"=>"2007",
        "authors"=>"D.S. Armstrong et al."},
        "commit"=>"Guardar",
        "id"=>"37",
        :user_genericwork=>{"userrole_id"=>"1"}
      }
      @record.fill(params)
      puts @record.model.genericwork.title
      @record.update_models
      @record = ModelSerialize.new([ UserGenericwork, Genericwork], @record.id)
      puts @record.model.genericwork.title
    
   end
end
