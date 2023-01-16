Jobposition.blueprint do 
    start_date  { Date.today }
    startyear  { Forgery(:basic).number }
    institution_id  { Institution.new.id }
    jobpositioncategory_id  { Jobpositioncategory.new.id }
    contracttype_id  { Contracttype.new.id }
    user_id  { User.new.id }
    institution
    jobpositioncategory
    contracttype
    user
end