Jobposition.blueprint do 
    start_date  { Date.today }
    startyear  { Forgery(:basic).number }
    institution_id  { Institution.make!.id }
    jobpositioncategory_id  { Jobpositioncategory.make!.id }
    contracttype_id  { Contracttype.make!.id }
    user_id  { User.make!.id }
    institution
    jobpositioncategory
    contracttype
    user
end