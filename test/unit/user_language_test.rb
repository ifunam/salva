require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'institution'
require 'language'
require 'languagelevel'
require 'user_language'

class UserLanguageTest < Test::Unit::TestCase
  fixtures :userstatuses, :countries, :states, :cities, :institutiontypes, :institutiontitles, :institutions, :users, :languagelevels, :languages, :user_languages

  def setup
    @user_languages = %w(user_languages_001 user_languages_002)
    @myuser_language = UserLanguage.new({ :user_id => 3, :language_id => 2, :spoken_languagelevel_id => 2 , :written_languagelevel_id => 3, :institution_id => 1})
  end

  # Right - CRUD
  def test_creating_user_language_from_yaml
    @user_languages.each { | user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      assert_kind_of UserLanguage, @user_language
      assert_equal user_languages(user_language.to_sym).id, @user_language.id
      assert_equal user_languages(user_language.to_sym).user_id, @user_language.user_id
      assert_equal user_languages(user_language.to_sym).language_id, @user_language.language_id
      assert_equal user_languages(user_language.to_sym).spoken_languagelevel_id, @user_language.spoken_languagelevel_id
      assert_equal user_languages(user_language.to_sym).written_languagelevel_id, @user_language.written_languagelevel_id
      assert_equal user_languages(user_language.to_sym).institution_id, @user_language.institution_id
    }
  end

  def test_updating_language_id
    @user_languages.each { |user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      assert_equal user_languages(user_language.to_sym).language_id, @user_language.language_id
      @user_language.language_id = 5
      assert @user_language.save
      assert_not_equal user_languages(user_language.to_sym).language_id, @user_language.language_id
    }
  end

   def test_updating_user_id
    @user_languages.each { |user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      assert_equal user_languages(user_language.to_sym).user_id, @user_language.user_id
      @user_language.user_id = 1
      assert @user_language.save
      assert_not_equal user_languages(user_language.to_sym).user_id, @user_language.user_id
    }
  end

   def test_updating_spoken_languagelevel_id
    @user_languages.each { |user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      assert_equal user_languages(user_language.to_sym).spoken_languagelevel_id, @user_language.spoken_languagelevel_id
      @user_language.spoken_languagelevel_id = 2
      assert @user_language.save
      assert_not_equal user_languages(user_language.to_sym).spoken_languagelevel_id, @user_language.spoken_languagelevel_id
    }
  end

   def test_updating_written_languagelevel_id
    @user_languages.each { |user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      assert_equal user_languages(user_language.to_sym).written_languagelevel_id, @user_language.written_languagelevel_id
      @user_language.written_languagelevel_id = 1
      assert @user_language.save
      assert_not_equal user_languages(user_language.to_sym).written_languagelevel_id, @user_language.written_languagelevel_id
    }
  end

      def test_updating_institution_id
    @user_languages.each { |user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      assert_equal user_languages(user_language.to_sym).institution_id, @user_language.institution_id
      @user_language.institution_id = 5588
      assert @user_language.save
      assert_not_equal user_languages(user_language.to_sym).institution_id, @user_language.institution_id
    }
  end

  def test_deleting_user_languages
    @user_languages.each { |user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      @user_language.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserLanguage.find(user_languages(user_language.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_language = UserLanguage.new
    assert !@user_language.save
  end

     def test_creating_duplicated
     @user_language = UserLanguage.new({:user_id => 2, :language_id => 1, :institution_id => 71 })
     assert !@user_language.save
   end

   # Boundary
    def test_bad_values_for_id
     @myuser_language.id = 1.6
     assert !@myuser_language.valid?
     @myuser_language.id = 'mi_id'
     assert !@myuser_language.valid?
  end

  def test_bad_values_for_user_id
    @myuser_language.user_id= 1.6
    assert !@myuser_language.valid?
    @myuser_language.user_id = 'mi_id_texto'
    assert !@myuser_language.valid?
  end

  def test_bad_values_for_language_id
    @myuser_language.language_id = nil
    assert !@myuser_language.valid?
    @myuser_language.language_id = 1.6
    assert !@myuser_language.valid?
    @myuser_language.language_id = 'mi_id_texto'
    assert !@myuser_language.valid?
  end

  def test_bad_values_for_spoken_languagelevel_id
    @myuser_language.spoken_languagelevel_id = nil
    assert !@myuser_language.valid?
    @myuser_language.spoken_languagelevel_id = 1.6
    assert !@myuser_language.valid?
    @myuser_language.spoken_languagelevel_id = 'mi_id_texto'
    assert !@myuser_language.valid?
  end

   def test_bad_values_for_written_languagelevel_id
    @myuser_language.written_languagelevel_id = nil
    assert !@myuser_language.valid?
    @myuser_language.written_languagelevel_id = 1.6
    assert !@myuser_language.valid?
    @myuser_language.written_languagelevel_id = 'mi_id_texto'
    assert !@myuser_language.valid?
  end

  #cross-Checking test for user
  def test_cross_checking_for_user_id
    @user_languages.each { | user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      assert_kind_of UserLanguage, @user_language
      assert_equal @user_language.user_id, User.find(@user_language.user_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_user_id
    @user_languages.each { | user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      assert_kind_of UserLanguage, @user_language
      @user_language.user_id = 5
      begin
        return true if @user_language.save
           rescue StandardError => x
        return false
      end
    }
  end

    #cross-Checking test for language
  def test_cross_checking_for_language_id
    @user_languages.each { | user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      assert_kind_of UserLanguage, @user_language
      assert_equal @user_language.language_id, Language.find(@user_language.language_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_language_id
    @user_languages.each { | user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      assert_kind_of UserLanguage, @user_language
      @user_language.language_id = 100000
      begin
        return true if @user_language.save
           rescue StandardError => x
        return false
      end
    }
  end

      #cross-Checking test for spoken_languagelevel_id
  def test_cross_checking_for_spoken_languagelevel_id
    @user_languages.each { | user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      assert_kind_of UserLanguage, @user_language
      assert_equal @user_language.spoken_languagelevel_id, Languagelevel.find(@user_language.spoken_languagelevel_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_spoken_languagelevel_id
    @user_languages.each { | user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      assert_kind_of UserLanguage, @user_language
      @user_language.spoken_languagelevel_id = 100000
      begin
        return true if @user_language.save
           rescue StandardError => x
        return false
      end
    }
  end

        #cross-Checking test for written_languagelevel_id
  def test_cross_checking_for_written_languagelevel_id
    @user_languages.each { | user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      assert_kind_of UserLanguage, @user_language
      assert_equal @user_language.written_languagelevel_id, Languagelevel.find(@user_language.written_languagelevel_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_written_languagelevel_id
    @user_languages.each { | user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      assert_kind_of UserLanguage, @user_language
      @user_language.written_languagelevel_id = 100000
      begin
        return true if @user_language.save
           rescue StandardError => x
        return false
      end
    }
  end

  #cross check for institution
  def test_cross_checking_for_institution_id
    @user_languages.each { | user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      assert_kind_of UserLanguage, @user_language
      assert_equal @user_language.institution_id, Institution.find(@user_language.institution_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_institution_id
    @user_languages.each { | user_language|
      @user_language = UserLanguage.find(user_languages(user_language.to_sym).id)
      assert_kind_of UserLanguage, @user_language
      @user_language.institution_id = 2000
       begin
        return true if @user_language.save
       rescue StandardError => x
        return false
      end
    }
  end
end
