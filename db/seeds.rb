# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

create_account = User.create([email: 'abc@gmail.com', password: '111111', password_confirmation: '111111', is_admin: 'true'])
puts "Admin account created."

jobs = [
  "RoR工程师",
  "产品经理",
  "HTML5工程师",
  "微信运营",
  "测试工程师",
  "销售总监",
  "高级执行总监",
  "人力资源总监",
  "成本核算师",
  "UI设计师"
]
category_name = [
  "技术",
  "运营",
  "市场与销售",
  "职能",
  "金融",
  "高级管理",
  "金融"
]
company = [
  "BridgeWater",
  "阿里巴巴集团",
  "腾讯科技深圳有限公司",
  "美团",
  "京东",
  "云币",
  "特斯拉Tesla中国"
]
location = [
  "北京",
  "上海",
  "广州",
  "深圳",
  "杭州"
]

create_jos = for i in 1..10 do
  Job.create!([
    title: jobs[rand(jobs.length)],
    # title: "JOB.no#{i}",
    description: "这是用种子建立的第 #{i} 个Public工作",
    wage_upper_bound: rand(50..99)*1 + 5,
    wage_lower_bound: rand(10..49)*1 + 5,
    contact_email: 'abc@gmail.com',
    is_hidden: "false",
    location: location[rand(location.length)],
    company: company[rand(company.length)],
    contact_email: "hr@info.com",
    category_name: category_name[rand(category_name.length)]
  ])
end

puts "10 Public jobs was created."

create_jos = for i in 1..10 do
  Job.create!([
    title: jobs[rand(jobs.length)],
    # title: "JOB.no#{i}",
    description: "这是用种子建立的第 #{i+10} 个归档工作",
    wage_upper_bound: rand(50..99)*100 + 5000,
    wage_lower_bound: rand(10..49)*100 + 5000,
    contact_email: 'abc@gmail.com',
    is_hidden: "true",
    location: location[rand(location.length)],
    company: company[rand(company.length)],
    contact_email: "hr@info.com",
    category_name: category_name[rand(category_name.length)]
  ])
end
puts "10 Hidden jobs was created."
