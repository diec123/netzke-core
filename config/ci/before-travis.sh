# Start xvfb in preparation for cucumber
export DISPLAY=:99.0
sh -e /etc/init.d/xvfb start

# fetch extjs
wget http://cdn.sencha.io/ext-4.0.7-gpl.zip
unzip -q -d test/core_test_app/public/ -n ext-4.0.7-gpl.zip
mv test/core_test_app/public/ext-4.0.7-gpl test/core_test_app/public/extjs

# cp db configuration
cp test/core_test_app/config/database.yml.travis  test/core_test_app/config/database.yml

# create mysql database
mysql -e 'create database nct_test;'

cd test/core_test_app
bundle install
bundle exec rake db:migrate RAILS_ENV=test
cd ../..
