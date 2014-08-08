class MoodleCoursesController < ApplicationController
    before_filter :check_authentication
    protect_from_forgery
    layout "dashboard"

    def index
    	@courses = MoodleCourse.all()
        @moodlegroups = MoodleGroup.joins("left join moodle_group_assignations as mga
                                            on moodle_groups.id = mga.groupid").select("moodle_groups.id as id,
                                                                                        moodle_groups.groupname as groupname,
                                                                                        count(distinct mga.m_courseid) as courses").group("id")
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
        redirect_to :action => "show_group", :id => params[:groupid]
    end

    def destroy_assignation
        g = MoodleGroupAssignation.where(:groupid => params[:groupid], :m_courseid => params[:courseid])
        g.destroy_all
        redirect_to :action => "show_group", :id => params[:groupid]
    end

    def show_group
        @courses = MoodleCourse.joins("inner join moodle_group_assignations as mga
                                       on mga.m_courseid = moodle_courses.moodleid
                                       and mga.groupid = #{params[:id]}")
        @group = params[:id]
        courselist = []
        @courses.each do |c|
            courselist << c.moodleid
        end
        @remaining_courses = MoodleCourse.where("moodleid not in (?)", courselist)
    end

    def create_group
        if params[:groupname]
            g = MoodleGroup.create(params.permit(:groupname))
            flash[:notice] = "Nuevo grupo de cursos creado"
        end
        redirect_to :action => "index"
    end

    def destroy_group
        MoodleGroup.find(params[:id]).destroy
        flash[:notice] = "Grupo eliminado."
        redirect_to :action => "index"
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
