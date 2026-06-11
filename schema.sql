-- 1. Таблица клиентов (демографическая информация)
CREATE TABLE clients (
    client_id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    gender TEXT CHECK(gender IN ('M', 'F')),
    birth_date DATE,
    city TEXT,
    registration_date DATE,
    is_active BOOLEAN DEFAULT 1
);

-- 2. Таблица счетов (продукты клиента)
CREATE TABLE accounts (
    account_id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_id INTEGER,
    account_type TEXT CHECK(account_type IN ('current', 'savings', 'credit', 'deposit')),
    open_date DATE,
    close_date DATE,
    balance DECIMAL(15,2) DEFAULT 0.00,
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

-- 3. Таблица транзакций (операции по счетам)
CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY AUTOINCREMENT,
    account_id INTEGER,
    transaction_date DATETIME,
    amount DECIMAL(15,2),
    transaction_type TEXT CHECK(transaction_type IN ('incoming', 'outgoing', 'payment', 'transfer')),
    description TEXT,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- 4. Таблица маркетинговых коммуникаций (для кого-то уже отправляли предложения)
CREATE TABLE marketing_communications (
    comm_id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_id INTEGER,
    campaign_name TEXT,
    communication_date DATE,
    channel TEXT CHECK(channel IN ('email', 'sms', 'push', 'call')),
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
);