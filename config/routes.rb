Rails.application.routes.draw do
  root :to => 'apps#index'

  get 'app/demo' => 'apps#demo'

  #User
    devise_for :users
    resources :users, :only => [:index, :edit, :update, :show]
    post 'user/confirm' => 'users#confirm'
    post 'user/complete' => 'users#complete'

  #Team
    resources :teams, :only => [:new, :create, :index, :show, :edit, :update, :destroy]
    # post 'team/confirm' => 'teams#confirm'
    get 'team/complete' => 'teams#complete'

  #Member(invite/apply)
    resources :members, :only => [:new, :create, :index, :update, :delete, :destroy]
    # post 'member/invite/:id' => 'members#invite', as: 'member_invite'
    get 'member/invite/:id' => 'members#invite', as: 'member_invite'
    get 'member/invited' => 'members#invited', as: 'member_invited'
    get 'member/apply' => 'members#apply', as: 'member_apply'

  #Scheudle
    resources :schedules, :only => [:new, :create, :index, :show, :edit, :update, :destroy]

  #Pparticipate
    resources :participates, :only => [:index, :create, :new, :update, :destroy, :show]

  #Game
    resources :games, :only => [:new, :create, :index, :show, :edit, :update, :destroy]

  #Message
  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end
  
end
