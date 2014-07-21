class CreateDefaultTitles < ActiveRecord::Migration
  def up
  	RequestDefaultTitle.create(:area_id => 4, :title => "Solicitud de Incorporación / Eliminación de Estudiante a Curso")
  	RequestDefaultTitle.create(:area_id => 4, :title => "Solicitud de Incorporación / Eliminación de Profesor a Curso")
  	RequestDefaultTitle.create(:area_id => 4, :title => "Solicitud de Creación de Nuevo Curso en Web Estudiantes")
  	RequestDefaultTitle.create(:area_id => 4, :title => "Problemas de acceso a la Web / Mail")
  	RequestDefaultTitle.create(:area_id => 4, :title => "Notificación de Error detectado en Material Web")
  	RequestDefaultTitle.create(:area_id => 4, :title => "Notificación de Problema detectado en Portal Summit")
  end

  def down
  	RequestDefaultTitle.all().destroy_all
  end
end
