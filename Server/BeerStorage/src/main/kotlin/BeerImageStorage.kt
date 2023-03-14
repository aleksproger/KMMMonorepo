package Server.BeerStorage

import Multiplatform.Storage.Storage
import Server.BeerStorage.BeerStorageSQL
import com.squareup.sqldelight.sqlite.driver.JdbcSqliteDriver
import java.io.File


fun imageStorage(databasePath: String = "src/main/resources/beer.db"): Storage<String, String> {
    return BeerImageStorage(databasePath)
}

private class BeerImageStorage(
    databasePath: String
): Storage<String, String> {
    private val driver = JdbcSqliteDriver("jdbc:sqlite:$databasePath")
    private val database = BeerStorageSQL(driver)

    init {
        if (!File(databasePath).exists()) {
            BeerStorageSQL.Schema.create(driver)
        }
    }

    override fun set(key: String, value: String) {
        return database.beerImageQueries.set(key, value)
    }

    override fun get(key: String): String? {
        database.beerImageQueries.get(key).executeAsOneOrNull()?.let {
            return it
        }
        return null
    }
}