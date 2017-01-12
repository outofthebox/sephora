class AddAttachmentSephoraPicksHotNowMustHaveToAnimation < ActiveRecord::Migration
  def self.up
    add_column :animations, :sephora_picks_file_name, :string
    add_column :animations, :sephora_picks_content_type, :string
    add_column :animations, :sephora_picks_file_size, :integer
    add_column :animations, :sephora_picks_updated_at, :datetime
    add_column :animations, :hot_now_file_name, :string
    add_column :animations, :hot_now_content_type, :string
    add_column :animations, :hot_now_file_size, :integer
    add_column :animations, :hot_now_updated_at, :datetime
    add_column :animations, :must_have_file_name, :string
    add_column :animations, :must_have_content_type, :string
    add_column :animations, :must_have_file_size, :integer
    add_column :animations, :must_have_updated_at, :datetime
  end

  def self.down
    remove_column :animations, :sephora_picks_file_name
    remove_column :animations, :sephora_picks_content_type
    remove_column :animations, :sephora_picks_file_size
    remove_column :animations, :sephora_picks_updated_at
    remove_column :animations, :hot_now_file_name
    remove_column :animations, :hot_now_content_type
    remove_column :animations, :hot_now_file_size
    remove_column :animations, :hot_now_updated_at
    remove_column :animations, :must_have_file_name
    remove_column :animations, :must_have_content_type
    remove_column :animations, :must_have_file_size
    remove_column :animations, :must_have_updated_at
  end
end
