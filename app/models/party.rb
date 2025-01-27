class Party < ApplicationRecord
  validates_presence_of :duration,
                        :date,
                        :start_time
                        #movie_id

  has_many :user_parties
  has_many :users, through: :user_parties

  def host
    users
      .where('user_parties.status = ?', 'Host')
      .first
  end

  def attendees
    users
      .where('user_parties.status = ?', 'Invited')
  end

  def movie(id)#test this
     MovieFacade.movie_id_search(id)
  end

end
