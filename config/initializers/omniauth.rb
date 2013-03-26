Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '461984797203347', '51718931054ca5790089a2ce55f18586'
  provider :twitter, 'u43sG2KyD2r4jWvvVYmWA', 'mTD7vYeMeSx3BEdu3s2d7mYP90Z5JfaBcAKnqTdS8'
end
