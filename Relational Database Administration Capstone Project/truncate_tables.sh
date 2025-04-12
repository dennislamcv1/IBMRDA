#!/bin/bash

DB_NAME="sales"

echo "🔻 Disabling foreign key checks..."
mysql -u root -e "USE $DB_NAME; SET FOREIGN_KEY_CHECKS = 0;" || exit 1

echo "🧹 Fetching table names..."
TABLES=$(mysql -u root -N -e "SELECT table_name FROM information_schema.tables WHERE table_schema = '$DB_NAME';")

if [ -z "$TABLES" ]; then
    echo "❌ No tables found in database '$DB_NAME'."
    exit 1
fi

echo "🚨 Truncating all tables in '$DB_NAME'..."
for TABLE in $TABLES; do
    echo "Truncating: $TABLE"
    mysql -u root -e "USE $DB_NAME; TRUNCATE TABLE \`$TABLE\`;"
done

echo "✅ Re-enabling foreign key checks..."
mysql -u root -e "USE $DB_NAME; SET FOREIGN_KEY_CHECKS = 1;"

echo "✅ All tables truncated successfully."
