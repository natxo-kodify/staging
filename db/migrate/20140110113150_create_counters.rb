class CreateCounters < ActiveRecord::Migration
  def up
    create_table :projects do |t|
      t.string :project
      t.string :used_by
      t.timestamps
    end
    add_index(:projects,[:project],:unique=>true)

    Project.create(project: 'katt', used_by: 'natxo')
    Project.create(project: 'kumm', used_by: 'tomoki')
    Project.create(project: 'fux', used_by: '')
    Project.create(project: 'stool', used_by: 'adria')

  end

  def down
    drop_table :projects
  end
end
