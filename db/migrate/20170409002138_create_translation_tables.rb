class CreateTranslationTables < ActiveRecord::Migration[5.0]
  def up
    Initiative.create_translation_table!({
      title: :string,
      description: :text
    },
    {
      migrate_data: true,
      remove_source_columns: true
    })

    MemberProfile.create_translation_table!({
      position: :string,
      bio: :text
    },
    {
      migrate_data: true,
      remove_source_columns: true
    })

    Partnership.create_translation_table!({
      name: :string,
      description: :text
    },
    {
      migrate_data: true,
      remove_source_columns: true
    })

    Team.create_translation_table!({
      name: :string,
      description: :text
    },
    {
      migrate_data: true,
      remove_source_columns: true
    })
  end

  def down
    Initiative.drop_translation_table! migrate_data: true
    MemberProfile.drop_translation_table! migrate_data: true
    Partnership.drop_translation_table! migrate_data: true
    Team.drop_translation_table! migrate_data: true
  end
end
