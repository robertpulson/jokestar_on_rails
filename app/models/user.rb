class User < ActiveRecord::Base

  after_initialize :defaults
  has_many :jokes, dependent: :destroy
  has_many :stars, dependent: :destroy
  has_many :starred_jokes, through: :stars, source: :joke, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  DEFAULT_RANK = :snowflake
  RANKS = { 0   => :buffoon,
            5   => :performing_monkey,
            10  => :stooge,
            15  => :clown,
            20  => :jester,
            25  => :imp,
            30  => :funny_guy,
            35  => :kidder,
            40  => :funster,
            45  => :josher,
            50  => :trickster,
            55  => :hoaxer,
            60  => :prankster,
            65  => :jokester,
            70  => :wise_cracker,
            75  => :entertainer,
            80  => :life_of_the_party,
            85  => :comic,
            90  => :joker,
            100 => :'joke*' }

  def defaults
    self.rating ||= 0
  end

  def owns_joke? joke
    id == joke.user_id
  end

  def starred? joke
    starred_jokes.include? joke
  end

  def increment_rating! points=1
    self.rating += points
    self.save
  end

  def decrement_rating!
    self.rating -= 1
    self.save
  end
end
