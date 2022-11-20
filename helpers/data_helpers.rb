module DataHelpers 
  def projects_including_skills
    @result ||= data.projects.map do |project| 
      array_of_matches = data.projects_skills.select { | sp | sp.project_id == project.id }
      array_of_skills = array_of_matches.map { |item| data.skills.find { |skill| skill.id == item.skill_id} }
      project.skills = array_of_skills
      project
    end
    @result
  end

  def projects_using(skill_param)
    mapped_filtered = projects_including_skills.select { |s| s.skills.any? {|h| h[:slug] == skill_param} }
    skill_param ? mapped_filtered : projects_including_skills 
  end

  def skills_including_projects
    @result_2 ||= data.skills.map do |skill| 
      array_of_matches = data.projects_skills.select { | sp | sp.skill_id == skill.id }
      array_of_projects = array_of_matches.map { |item| data.projects.find { |project| project.id == item.project_id} }
      skill.projects = array_of_projects
      skill
    end
    @result_2
  end

  def skills_using(project_param)
    mapped_filtered = skills_including_projects.select { |s| s.projects.any? {|h| h[:slug] == project_param} }
    project_param ? mapped_filtered : skills_including_projects 
  end

end
