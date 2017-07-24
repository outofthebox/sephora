class RedactorAsset < ActiveRecord::Base
	attr_accessor 	:asset
	has_attached_file 	:asset, :styles => { :original => "800x800>", :thumb => "118x100>" }, :url => "/system/redactorAssets/:style/:hash.:extension",  :hash_secret => "longSecretString"
end
