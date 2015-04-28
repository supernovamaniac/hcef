class StaticController < ApplicationController
  def home
  end

  def login
  end

  def master_view_new
    @locations = Location.all.alphabetical
  end

  def master_view_submit
    location_indices = params["locations"]
    if !location_indices.nil? 
      # Cast location_indices to integers
      location_indices.map!(&:to_i)
      # Rejects all locations that are in the ith index spot of the array
      allLocations = Location.all.alphabetical
      locations = allLocations.reject!.with_index { |l, i| !location_indices.include? i }
      # The case where all locations are selected, so reject! will return nil since there is no change from allLocaitons
      locations = allLocations if locations.nil?
      after_schools = []
        #Data of one element: [child record, avg homework, avg literacy, avg technology, avg reading_specialist, total_time]
        after_schools_children = []
      enrichments = []
        #Data of one element: child record
        enrichments_children = []
      field_trips = []
        #Data of one element: child record
        field_trips_children = []
      locations.each do |l|
        after_school_index = 0
        enrichment_index = 0
        field_trip_index = 0
        l.programs.each_with_index do |p, i|
          # Gather all program_types
          if p.program_type == 'after_school'
            after_schools << p
            
            after_schools_children[after_school_index] = [] if after_schools_children[after_school_index].nil?
            #Gather all children data
            p.children.each do |c|
              after_schools_children[after_school_index] << [c, 5, 5, 5, 5, 2000]
            end
            after_school_index += 1
          elsif p.program_type == 'enrichment'
            enrichments << p

            enrichments_children[enrichment_index] = [] if enrichments_children[enrichment_index].nil?
            #Gather all children data
            p.children.each do |c|
              enrichments_children[enrichment_index] << c
            end
            enrichment_index += 1
          elsif p.program_type == 'field_trip'
            field_trips << p

            field_trips_children[field_trip_index] = [] if field_trips_children[field_trip_index].nil?
            #Gather all children data
            p.children.each do |c|
              field_trips_children[field_trip_index] << c
            end
            field_trip_index += 1
          end
        end
      end
    end
    render :json => {locations: locations, after_schools: after_schools, enrichments: enrichments, field_trips: field_trips, after_schools_children: after_schools_children, enrichments_children: enrichments_children, field_trips_children: field_trips_children} 
  end



  def admin_dash
    @student_count = Child.all.count
    @program_count = Program.all.count
    @afterschool = Program.where("program_type=?", "after_school").count
    @enrichment = Program.where("program_type=?", "enrichment").count
    @field_trip = Program.where("program_type=?", "field_trip").count
    @location_count = Location.all.count
    @q = Child.ransack(params[:q])
    @children = @q.result(distinct: true).alphabetical.paginate(:page => params[:children_page], :per_page => 10)
    #@children = Child.all.alphabetical.paginate(:page => params[:children_page], :per_page => 10)
    @instructors = Instructor.all.alphabetical.paginate(:page => params[:instructors_page], :per_page => 10)
    @locations = Location.all.alphabetical.paginate(:page => params[:locations_page], :per_page => 10)
    @schools = School.all.paginate(:page => params[:schools_page], :per_page => 10)
  end

end
