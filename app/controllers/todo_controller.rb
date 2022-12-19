class TodoController < ApplicationController

  def index
    query = "
      SELECT
        subjects.id,
        subjects.name,
        jsonb_agg(jsonb_build_object(
          'id', t.id, 'name', t.name
              )) AS topics
      FROM
        subjects
      LEFT JOIN subject_users su ON
        su.subject_id = subjects.id
      INNER JOIN topics t ON
        t.subject_id = subjects.id
      WHERE su.user_id = '#{current_user.id}'
      GROUP BY
        subjects.name,
        subjects.id
    "

    query = ActiveRecord::Base.connection.exec_query(query)

    query.map do |subject|
      subject['topics'] = JSON.parse(subject['topics'])
    end
    
    render json: query, status: 200
  end

  private

  def api_params
    params.permit(:name, :start_date, :end_date, :shift)
  end
end
