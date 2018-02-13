require ('pg')

class Bounty

  attr_accessor :name, :species, :bounty_value, :danger_value
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @bounty_value = options['bounty_value']
    @danger_value = options['danger_value']
  end

  def save()
    db = PG.connect ( { dbname: 'space_cowboys', host: 'localhost' } )

    sql =
    "INSERT INTO bounty
    (
      name,
      species,
      bounty_value,
      danger_value)

      VALUES
      (
        $1, $2, $3, $4
        )
        RETURNING *;
        "

        values = [@name, @species, @bounty_value, @danger_value]
        db.prepare("save", sql)
        @id = db.exec_prepared("save", values)[0]['id'].to_i
        db.close
      end

      def update()
        db = PG.connect ( { dbname: 'space_cowboys', host: 'localhost' } )
        sql =
        "UPDATE bounty
        SET
        (
          name,
          species,
          bounty_value,
          danger_value
          ) =
          (
            $1, $2, $3, $4
          )
          WHERE id = $5
          RETURNING *
          ;"
          values =[@name, @species, @bounty_value, @danger_value, @id]
          db.prepare("update", sql)
          @id = db.exec_prepared("update", values)[0]['id'].to_i
          db.close
        end

        def delete()
          db = PG.connect ( { dbname: 'space_cowboys', host: 'localhost' } )
          sql =
          "DELETE FROM bounty WHERE id = $1
          RETURNING * ;"
          values = [@id]
          db.prepare("delete_one", sql)
          @id = db.exec_prepared("delete_one", values)[0]['id'].to_i
          db.close
        end

        def Bounty.find(id)
          db = PG.connect( { dbname: 'space_cowboys', host: 'localhost'})
          sql = "SELECT * FROM bounty WHERE id = $1;"
          values = [id]
          db.prepare("find_id", sql)
          finds = db.exec_prepared("find_id", values)
          db.close
          return finds.map {|find| Bounty.new(find)}
        end

      end #end of class
