// seed.js
require('dotenv').config();
const { Pool } = require('pg');
const bcrypt = require('bcryptjs');

// This will use the settings from your .env.demo file
// (once you rename it to .env)
const pool = new Pool(); 

async function seedDatabase() {
  const client = await pool.connect();
  console.log('Connecting to database to seed data...');

  try {
    await client.query('BEGIN');

    // --- 1. Create Staff Users (So you can log in!) ---
    console.log('Seeding staff_users...');
    const masterHash = await bcrypt.hash('master123', 12);
    const operatorHash = await bcrypt.hash('operator123', 12);
    
    // Create a Master user
    await client.query(
      `INSERT INTO staff_users (username, password_hash, role, is_active) 
       VALUES ('master_user', $1, 'master', true) 
       ON CONFLICT (username) DO NOTHING`, [masterHash]
    );
    // Create an Operator user
    await client.query(
      `INSERT INTO staff_users (username, password_hash, role, is_active) 
       VALUES ('operator_user', $1, 'operator', true) 
       ON CONFLICT (username) DO NOTHING`, [operatorHash]
    );
    console.log('Staff users seeded.');

    // --- 2. Seed Company Settings (For the logo) ---
    console.log('Seeding company_settings...');
    // This uses a logo in your Public/uploads folder
    await client.query(
      `INSERT INTO company_settings (id, company_name, logo_url, address, city) 
       VALUES (1, 'Reva Zone Demo', '/uploads/company-logo.png', '123 Demo Street', 'Riyadh') 
       ON CONFLICT (id) DO UPDATE SET 
         company_name = EXCLUDED.company_name, logo_url = EXCLUDED.logo_url`
    );
    console.log('Company settings seeded.');

    // --- 3. Seed Reference Data (For LiteBill) ---
    console.log('Seeding reference_data...');
    await client.query(
      `INSERT INTO reference_data (owner_id, device_serialno, customer_name) VALUES
       (1, 'METER-001', 'Al-Othaim Markets'),
       (1, 'METER-002', 'Panda Retail'),
       (1, 'METER-003', 'Jarir Bookstore')
       ON CONFLICT DO NOTHING`
    );
    console.log('Reference data seeded.');
    
    // --- 4. Seed Billing Data (For Dashboards) ---
    console.log('Seeding final_billing_data...');
    await client.query(
      `INSERT INTO final_billing_data (upload_month, device_serialno, customer_name, net_consumption_m3, total_bill_amount_sar, vat_percent, upload_tariff_sar) VALUES
       ('2025-10', 'METER-001', 'Al-Othaim Markets', 150.5, 850.25, 15, 5.0),
       ('2025-10', 'METER-002', 'Panda Retail', 220.0, 1200.00, 15, 5.0),
       ('2025-09', 'METER-001', 'Al-Othaim Markets', 140.0, 790.10, 15, 5.0)
       ON CONFLICT DO NOTHING`
    );
    console.log('Billing data seeded.');

    await client.query('COMMIT');
    console.log('✅ Database seeding complete!');

  } catch (e) {
    await client.query('ROLLBACK');
    console.error('Database seeding failed:', e);
  } finally {
    client.release();
    pool.end();
  }
}

seedDatabase();