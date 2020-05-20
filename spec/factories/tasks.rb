FactoryBot.define do
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    deadline { '2000-1-1' }
    priority { 0 }
    status { 0 }
  end
  
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    deadline { '2111-1-1' }
    priority { 1 }
    status { 1 }
  end
end