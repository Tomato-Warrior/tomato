Tictac.delete_all
Tagging.delete_all
Tag.delete_all

TrelloInfo.delete_all
Task.delete_all
Project.delete_all
User.delete_all
puts "remove data success"

user = User.create!({email: 'meowdemo@com',
password: '111111', auth_token: "ATBFohaV1cf5Wnfbq9d39PFA"})
puts " create user #{user.id} success !! "

project = user.projects.create({title: '例行公務'})
puts "create project #{project.title} success!!!!"


task_titles = ['打掃', '拖地', '倒垃圾', '煮飯']

task_titles.each do |title|

  t = Task.create!(
    user: user,
    title: title,
    project: project
  )
  
  t.tags.create({name: '家事'})

  puts "create task #{t.inspect} success"

  for i in 1..5 do 
    t.tictacs.create!(user: t.user, status: 'finished',
                      start_at: "2020-06-0#{i} 03:03:03",   
                      end_at: "2020-06-0#{i} 03:03:06")
  end
  for i in 1..5 do 
    t.tictacs.create!(user: t.user, status: 'finished',
                      start_at: "2020-06-1#{i} 03:03:03",   
                      end_at: "2020-06-1#{i} 03:03:06")
  end
  for i in 1..5 do 
    t.tictacs.create!(user: t.user, status: 'finished',
                      start_at: "2020-06-1#{i} 03:03:03",   
                      end_at: "2020-06-1#{i} 03:03:06")
  end
  for i in 1..2 do 
    t.tictacs.create!(user: t.user, status: 'finished',
                      start_at: "2020-05-#{i}#{i} 03:03:03",   
                      end_at: "2020-05-#{i}#{i} 03:03:06")
  end
  for i in 1..2 do 
    t.tictacs.create!(user: t.user, status: 'cancelled',
                      start_at: "2020-05-#{i}#{i} 03:03:03",   
                      end_at: "2020-05-#{i}#{i} 03:03:06")
  end
  for i in 1..9 do 
    t.tictacs.create!(user: t.user, status: 'finished',
                      start_at: "2020-05-0#{i} 03:03:03",   
                      end_at: "2020-05-0#{i} 03:03:06")
  end
  for i in 1..9 do 
    t.tictacs.create!(user: t.user, status: 'finished',
                      start_at: "2020-05-1#{i} 03:03:03",   
                      end_at: "2020-05-1#{i} 03:03:06")
  end
  for i in 1..9 do 
    t.tictacs.create!(user: t.user, status: 'finished',
                      start_at: "2020-05-2#{i} 03:03:03",   
                      end_at: "2020-05-2#{i} 03:03:06")
  end
  for i in 1..3 do 
    t.tictacs.create!(user: t.user, status: 'finished',
                      start_at: "2020-04-0#{i} 03:03:03",   
                      end_at: "2020-04-0#{i} 03:03:06")
  end
  for i in 1..2 do 
    t.tictacs.create!(user: t.user, status: 'finished',
                      start_at: "2020-07-#{i}#{i} 03:03:03",   
                      end_at: "2020-07-#{i}#{i} 03:03:06")
  end
  for i in 1..9 do 
    t.tictacs.create!(user: t.user, status: 'finished',
                      start_at: "2020-07-0#{i} 03:03:03",   
                      end_at: "2020-07-0#{i} 03:03:06")
  end
  t.tictacs.create!(user: t.user, status: 'cancelled',
  start_at: "2020-06-12 03:03:03",   
  end_at: "2020-06-12 03:03:06")
end


t2 = Task.create!(
  user: user,
  title: '寫部落格',
  project: project
)

t2.tags.create({name: '寫作'})

puts "create task #{t2.inspect} success"

for i in 1..5 do 
  t2.tictacs.create!(user: t2.user, status: 'finished',
                    start_at: "2020-06-0#{i} 03:03:03",   
                    end_at: "2020-06-0#{i} 03:03:06")
end

t2.tictacs.create!(user: t2.user, status: 'finished',
                    start_at: "2020-04-23 03:03:03",   
                    end_at: "2020-04-23 03:03:06")
t2.tictacs.create!(user: t2.user, status: 'finished',
                    start_at: "2020-04-12 03:03:03",   
                    end_at: "2020-04-12 03:03:06")
t2.tictacs.create!(user: t2.user, status: 'finished',
                    start_at: "2020-05-04 03:03:03",   
                    end_at: "2020-05-04 03:03:06")
for i in 1..2 do 
  t2.tictacs.create!(user: t2.user, status: 'finished',
                    start_at: "2020-05-#{i}#{i} 03:03:03",   
                    end_at: "2020-05-#{i}#{i} 03:03:06")
end
for i in 1..3 do 
  t2.tictacs.create!(user: t2.user, status: 'finished',
                    start_at: "2020-04-0#{i} 03:03:03",   
                    end_at: "2020-04-0#{i} 03:03:06")
end
for i in 1..3 do 
  t2.tictacs.create!(user: t2.user, status: 'finished',
                    start_at: "2020-04-0#{i} 03:03:03",   
                    end_at: "2020-04-0#{i} 03:03:06")
end
for i in 1..2 do 
  t2.tictacs.create!(user: t2.user, status: 'finished',
                    start_at: "2020-07-#{i}#{i} 03:03:03",   
                    end_at: "2020-07-#{i}#{i} 03:03:06")
end
for i in 1..2 do 
  t2.tictacs.create!(user: t2.user, status: 'finished',
                    start_at: "2020-07-#{i}#{i} 03:03:03",   
                    end_at: "2020-07-#{i}#{i} 03:03:06")
end
for i in 1..2 do 
  t2.tictacs.create!(user: t2.user, status: 'finished',
                    start_at: "2020-07-#{i}#{i} 03:03:03",   
                    end_at: "2020-07-#{i}#{i} 03:03:06")
end
for i in 1..9 do 
  t2.tictacs.create!(user: t2.user, status: 'finished',
                    start_at: "2020-07-0#{i} 03:03:03",   
                    end_at: "2020-07-0#{i} 03:03:06")
end
for i in 1..9 do 
  t2.tictacs.create!(user: t2.user, status: 'finished',
                    start_at: "2020-07-0#{i} 03:03:03",   
                    end_at: "2020-07-0#{i} 03:03:06")
end
for i in 1..9 do 
  t2.tictacs.create!(user: t2.user, status: 'finished',
                    start_at: "2020-07-0#{i} 03:03:03",   
                    end_at: "2020-07-0#{i} 03:03:06")
end

t3 = Task.create!(
  user: user,
  title: '彈吉他',
  project: project
)

t3.tags.create({name: '練樂器'})

puts "create task #{t3.inspect} success"

for i in 1..5 do 
  t3.tictacs.create!(user: t3.user, status: 'finished',
                    start_at: "2020-06-0#{i} 03:03:03",   
                    end_at: "2020-06-0#{i} 03:03:06")
end
for i in 1..2 do 
  t3.tictacs.create!(user: t3.user, status: 'finished',
                    start_at: "2020-05-#{i}#{i} 03:03:03",   
                    end_at: "2020-05-#{i}#{i} 03:03:06")
end
for i in 1..3 do 
  t3.tictacs.create!(user: t3.user, status: 'finished',
                    start_at: "2020-04-0#{i} 03:03:03",   
                    end_at: "2020-04-0#{i} 03:03:06")
end
for i in 1..2 do 
  t3.tictacs.create!(user: t3.user, status: 'finished',
                    start_at: "2020-07-#{i}#{i} 03:03:03",   
                    end_at: "2020-07-#{i}#{i} 03:03:06")
end
for i in 1..9 do 
  t3.tictacs.create!(user: t3.user, status: 'finished',
                    start_at: "2020-07-0#{i} 03:03:03",   
                    end_at: "2020-07-0#{i} 03:03:06")
end
