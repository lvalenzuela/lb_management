class MoodleCoursesController < ApplicationController
    before_filter :check_authentication
    protect_from_forgery
    layout "dashboard"

    def index        
        if params[:search]
            @moodlegroups = MoodleGroup.joins("left join moodle_group_assignations as mga
                on moodle_groups.id = mga.groupid").select("moodle_groups.id as id,
                                                    moodle_groups.groupname as groupname,
                                                    count(distinct mga.m_courseid) as courses").where("groupname LIKE '%#{params[:search]}%'").group("moodle_groups.id")
        else
            @moodlegroups = MoodleGroup.joins("left join moodle_group_assignations as mga
                on moodle_groups.id = mga.groupid").select("moodle_groups.id as id,
                                                    moodle_groups.groupname as groupname,
                                                    count(distinct mga.m_courseid) as courses").group("moodle_groups.id")
        end
    end

    def assign
        if params[:courses] && params[:groupid]
            params[:courses].each do |c|
                assign_to_group(params[:groupid],c)
            end
        else
            flash[:notice] = "No se pudo llevar a cabo la asignacion."
        end
        redirect_to :action => "index"
    end

    def assign_course
        assign_to_group(params[:groupid], params[:courseid])
        @group = MoodleGroup.find(params[:groupid])
        @courses = MoodleCourseV.joins("as moodle_courses inner join moodle_group_assignations as mga
                                       on mga.m_courseid = moodle_courses.moodleid
                                       and mga.groupid = #{params[:groupid]}").select("moodle_courses.*")
        respond_to do |format|
            format.js
        end
    end

    def destroy_assignation
        g = MoodleGroupAssignation.where(:groupid => params[:groupid], :m_courseid => params[:courseid])
        g.destroy_all
        @group = MoodleGroup.find(params[:groupid])
        @courses = MoodleCourseV.joins("as moodle_courses inner join moodle_group_assignations as mga
                                       on mga.m_courseid = moodle_courses.moodleid
                                       and mga.groupid = #{params[:groupid]}").select("moodle_courses.*")
        respond_to do |format|
            format.js
        end
    end

    def show_group
        @courses = MoodleCourseV.joins("as moodle_courses inner join moodle_group_assignations as mga
                                       on mga.m_courseid = moodle_courses.moodleid
                                       and mga.groupid = #{params[:id]}").select("moodle_courses.*")
        @group = MoodleGroup.find(params[:id])
        
        if @courses.blank?
            r_courses = MoodleCourseV.all()
        else
            r_courses = MoodleCourseV.where("moodleid not in (?)", @courses.map{|c| c.moodleid})
        end
        @remaining_courses = r_courses
    end

    def create_group
        if params[:groupname]
            g = MoodleGroup.create(params.permit(:groupname))
            flash[:notice] = "Nuevo grupo de cursos creado"
        end
        redirect_to :action => "index"
    end

    def destroy_group
        MoodleGroupAssignation.where(:groupid => params[:id]).destroy_all
        MoodleGroup.find(params[:id]).destroy
        flash[:notice] = "Grupo eliminado."
        redirect_to :action => "index"
    end

    def courses_list
        @templates = CourseTemplate.all()
        if params[:search]
            @courses = MoodleCourseV.where("coursename like '%#{params[:search]}%'").page(params[:page]).per(10)
        else
            @courses = MoodleCourseV.all().page(params[:page]).per(10)
        end
    end

    def set_template
        params[:courses].each do |c|
            course = MoodleCourse.find_by_moodleid(c)
            if params[:template_id]
                course.course_template_id = params[:template_id]
            end
            course.save!
        end
        redirect_to :action => :courses_list
    end

    def course_calendar
        @course = MoodleCourseV.find_by_moodleid(params[:id])
        @all_sessions = MoodleCourseSessionV.where(:courseid => params[:id])
        calendar_events = []
        @all_sessions.each do |s|
            calendar_events << {
                "title" => "Clases",
                "start" => s.session_date,
                "allDay" => false,
                "backgroundColor" => "#0073b7",
                "borderColor" => "#0073b7"
            }
        end
        gon.events = calendar_events
    end

    private

    def assign_to_group(groupid,courseid)
        g = MoodleGroupAssignation.where(:groupid => groupid, :m_courseid => courseid)
        if g.nil? || g.empty?
            #Se asignan los cursos seleccionados al grupo correspondiente
            MoodleGroupAssignation.create(:groupid => groupid, :m_courseid => courseid)
        else
            #El curso ya esta asignado al grupo
            #duh
        end
    end

    def check_authentication
        if current_user.nil?
          redirect_to :controller => "users", :action => "index"
        end
    end
end
