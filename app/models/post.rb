class Post < ApplicationRecord
	validates(:body, presence: true, length: {in: 1..90})
end
