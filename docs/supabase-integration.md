# Supabase Integration Guidelines

This document outlines Supabase integration patterns and best practices for the Expense Tracker Flutter application.

## Repository Pattern
Use the repository pattern to encapsulate Supabase API calls:

1. Define repository interfaces in `lib/backends/*/lib/src/repository/`
2. Implement Supabase-specific repositories in `lib/backends/*/lib/src/`
3. Keep model transformations in the repository layer

## Example Repository Interface
```dart
/// Repository for managing transactions in the system
abstract class TransactionRepository {
  /// Fetches all transactions for the current user
  Future<List<Transaction>> getTransactions();
  
  /// Fetches transactions filtered by date range
  Future<List<Transaction>> getTransactionsByDateRange(DateTime start, DateTime end);
  
  /// Fetches transactions filtered by category
  Future<List<Transaction>> getTransactionsByCategory(String categoryId);
  
  /// Fetches a single transaction by ID
  Future<Transaction?> getTransactionById(String id);
  
  /// Creates a new transaction
  Future<Transaction> addTransaction(Transaction transaction);
  
  /// Updates an existing transaction
  Future<Transaction> updateTransaction(Transaction transaction);
  
  /// Deletes a transaction by ID
  Future<void> deleteTransaction(String id);
  
  /// Gets spending summary for a date range
  Future<Map<String, double>> getSpendingSummary(DateTime start, DateTime end);
}
```

## Example Supabase Implementation

```dart
/// Supabase implementation of the TransactionRepository interface
class SupabaseTransactionRepository implements TransactionRepository {
  final SupabaseClient _client;
  
  SupabaseTransactionRepository(this._client);
  
  @override
  Future<List<Transaction>> getTransactions() async {
    final response = await _client
        .from('transactions')
        .select()
        .eq('user_id', await _getCurrentUserId())
        .order('date', ascending: false)
        .execute();
    
    if (response.error != null) {
      throw RepositoryException(response.error!.message);
    }
    
    return (response.data as List)
        .map((json) => Transaction.fromJson(json))
        .toList();
  }
  
  @override
  Future<List<Transaction>> getTransactionsByDateRange(DateTime start, DateTime end) async {
    final response = await _client
        .from('transactions')
        .select()
        .eq('user_id', await _getCurrentUserId())
        .gte('date', start.toIso8601String())
        .lte('date', end.toIso8601String())
        .order('date', ascending: false)
        .execute();
    
    if (response.error != null) {
      throw RepositoryException(response.error!.message);
    }
    
    return (response.data as List)
        .map((json) => Transaction.fromJson(json))
        .toList();
  }
  
  @override
  Future<List<Transaction>> getTransactionsByCategory(String categoryId) async {
    final response = await _client
        .from('transactions')
        .select()
        .eq('user_id', await _getCurrentUserId())
        .eq('category_id', categoryId)
        .order('date', ascending: false)
        .execute();
    
    if (response.error != null) {
      throw RepositoryException(response.error!.message);
    }
    
    return (response.data as List)
        .map((json) => Transaction.fromJson(json))
        .toList();
  }
  
  @override
  Future<Transaction?> getTransactionById(String id) async {
    final response = await _client
        .from('transactions')
        .select()
        .eq('id', id)
        .limit(1)
        .execute();
    
    if (response.error != null) {
      throw RepositoryException(response.error!.message);
    }
    
    if ((response.data as List).isEmpty) {
      return null;
    }
    
    return Transaction.fromJson(response.data[0]);
  }
  
  @override
  Future<Transaction> addTransaction(Transaction transaction) async {
    final response = await _client
        .from('transactions')
        .insert({
          ...transaction.toJson(),
          'user_id': await _getCurrentUserId(),
        })
        .execute();
    
    if (response.error != null) {
      throw RepositoryException(response.error!.message);
    }
    
    return Transaction.fromJson(response.data[0]);
  }
  
  @override
  Future<Transaction> updateTransaction(Transaction transaction) async {
    final response = await _client
        .from('transactions')
        .update(transaction.toJson())
        .eq('id', transaction.id)
        .execute();
    
    if (response.error != null) {
      throw RepositoryException(response.error!.message);
    }
    
    return Transaction.fromJson(response.data[0]);
  }
  
  @override
  Future<void> deleteTransaction(String id) async {
    final response = await _client
        .from('transactions')
        .delete()
        .eq('id', id)
        .execute();
    
    if (response.error != null) {
      throw RepositoryException(response.error!.message);
    }
  }
  
  @override
  Future<Map<String, double>> getSpendingSummary(DateTime start, DateTime end) async {
    final response = await _client
        .from('transactions')
        .select('category_id, amount')
        .eq('user_id', await _getCurrentUserId())
        .gte('date', start.toIso8601String())
        .lte('date', end.toIso8601String())
        .execute();
    
    if (response.error != null) {
      throw RepositoryException(response.error!.message);
    }
    
    final Map<String, double> summary = {};
    for (final transaction in response.data as List) {
      final categoryId = transaction['category_id'] as String;
      final amount = (transaction['amount'] as num).toDouble();
      summary[categoryId] = (summary[categoryId] ?? 0) + amount;
    }
    
    return summary;
  }
  
  Future<String> _getCurrentUserId() async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw AuthException('User not authenticated');
    }
    return user.id;
  }
}
```

## Error Handling with Supabase
Always handle Supabase errors and transform them to app-specific exceptions:

```dart
try {
  final response = await _client.from('transactions').select().execute();
  
  if (response.error != null) {
    throw RepositoryException(response.error!.message);
  }
  
  // Process data
} catch (e) {
  if (e is PostgrestError) {
    // Handle Supabase-specific errors
    if (e.code == 'PGRST301') {
      throw AuthorizationException('Not authorized to access transactions');
    }
  }
  // Rethrow or transform other exceptions
  throw RepositoryException('Failed to fetch transactions: $e');
}
```

## Supabase Client Setup

Initialize Supabase client in a central location:

```dart
// lib/core/supabase/supabase_client.dart
import 'package:supabase_flutter/supabase_flutter.dart';

/// Initializes the Supabase client for the application
Future<SupabaseClient> initializeSupabase() async {
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_ANON_KEY',
  );
  return Supabase.instance.client;
}
```

## Authentication

Use Supabase for authentication:

```dart
// Sign In
Future<void> signIn(String email, String password) async {
  final response = await _client.auth.signIn(
    email: email,
    password: password,
  );
  
  if (response.error != null) {
    throw AuthException(response.error!.message);
  }
  
  // User is now signed in
}

// Sign Up
Future<void> signUp(String email, String password) async {
  final response = await _client.auth.signUp(
    email: email,
    password: password,
  );
  
  if (response.error != null) {
    throw AuthException(response.error!.message);
  }
  
  // User is now signed up
}

// Sign Out
Future<void> signOut() async {
  await _client.auth.signOut();
}
```

## Realtime Subscriptions

Use Supabase realtime subscriptions for live updates:

```dart
void subscribeToTransactions() {
  _client
    .from('transactions')
    .on(SupabaseEventTypes.all, (payload) {
      // Handle realtime updates
      if (payload.eventType == SupabaseEventTypes.insert) {
        // A transaction was added
        final newTransaction = Transaction.fromJson(payload.newRecord);
        _transactionsStreamController.add([..._currentTransactions, newTransaction]);
      } else if (payload.eventType == SupabaseEventTypes.update) {
        // A transaction was updated
        final updatedTransaction = Transaction.fromJson(payload.newRecord);
        final updatedTransactions = _currentTransactions.map((transaction) => 
          transaction.id == updatedTransaction.id ? updatedTransaction : transaction
        ).toList();
        _transactionsStreamController.add(updatedTransactions);
      } else if (payload.eventType == SupabaseEventTypes.delete) {
        // A transaction was deleted
        final deletedId = payload.oldRecord['id'];
        final filteredTransactions = _currentTransactions
          .where((transaction) => transaction.id != deletedId)
          .toList();
        _transactionsStreamController.add(filteredTransactions);
      }
    })
    .subscribe();
}
```

## Working with JSONB Fields

When working with JSONB fields in Supabase, use appropriate serialization/deserialization:

```dart
// Converting Dart objects to JSONB
Map<String, dynamic> toJson() {
  return {
    // Regular fields
    'id': id,
    'title': title,
    'amount': amount,
    'category_id': categoryId,
    'type': type.toString(),
    'date': date.toIso8601String(),
    
    // JSONB field for additional metadata
    'metadata': {
      'tags': tags,
      'location': location != null ? {
        'latitude': location!.latitude,
        'longitude': location!.longitude,
        'address': location!.address,
      } : null,
      'receipt_data': receiptData?.toJson(),
    },
  };
}

// Converting JSONB to Dart objects
factory Transaction.fromJson(Map<String, dynamic> json) {
  // Extract data from JSONB
  final metadata = json['metadata'] as Map<String, dynamic>? ?? {};
  final locationData = metadata['location'] as Map<String, dynamic>?;
  final receiptData = metadata['receipt_data'] as Map<String, dynamic>?;
  
  return Transaction(
    id: json['id'] as String,
    title: json['title'] as String,
    amount: (json['amount'] as num).toDouble(),
    categoryId: json['category_id'] as String,
    type: TransactionType.fromString(json['type'] as String),
    date: DateTime.parse(json['date'] as String),
    
    // Parse from JSONB
    tags: (metadata['tags'] as List?)
        ?.map((e) => e as String)
        ?.toList() ?? [],
    location: locationData != null ? Location(
      latitude: locationData['latitude'] as double,
      longitude: locationData['longitude'] as double,
      address: locationData['address'] as String?,
    ) : null,
    receiptData: receiptData != null 
        ? ReceiptData.fromJson(receiptData) 
        : null,
  );
}
```

## Database Schema Best Practices

### Table Structure
```sql
-- Users table (handled by Supabase Auth)
-- Transactions table
CREATE TABLE transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  category_id UUID REFERENCES categories(id),
  type TEXT NOT NULL CHECK (type IN ('income', 'expense')),
  date TIMESTAMP WITH TIME ZONE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  notes TEXT,
  metadata JSONB DEFAULT '{}'::jsonb
);

-- Categories table
CREATE TABLE categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  icon TEXT,
  color TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Budgets table
CREATE TABLE budgets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  category_id UUID REFERENCES categories(id),
  amount DECIMAL(10,2) NOT NULL,
  period TEXT NOT NULL CHECK (period IN ('monthly', 'yearly')),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Row Level Security (RLS)
```sql
-- Enable RLS on all tables
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE budgets ENABLE ROW LEVEL SECURITY;

-- Policies for transactions
CREATE POLICY "Users can view their own transactions" 
  ON transactions FOR SELECT 
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own transactions" 
  ON transactions FOR INSERT 
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own transactions" 
  ON transactions FOR UPDATE 
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own transactions" 
  ON transactions FOR DELETE 
  USING (auth.uid() = user_id);

-- Similar policies for categories and budgets
```

### Indexes
```sql
-- Performance indexes
CREATE INDEX idx_transactions_user_id ON transactions(user_id);
CREATE INDEX idx_transactions_date ON transactions(date);
CREATE INDEX idx_transactions_category_id ON transactions(category_id);
CREATE INDEX idx_categories_user_id ON categories(user_id);
CREATE INDEX idx_budgets_user_id ON budgets(user_id);
```

## Testing Supabase Integration

### Unit Testing Repositories
```dart
class MockSupabaseClient extends Mock implements SupabaseClient {}

void main() {
  group('SupabaseTransactionRepository', () {
    late MockSupabaseClient mockClient;
    late SupabaseTransactionRepository repository;

    setUp(() {
      mockClient = MockSupabaseClient();
      repository = SupabaseTransactionRepository(mockClient);
    });

    test('should return transactions when getTransactions is called', () async {
      // Arrange
      final mockResponse = MockPostgrestResponse();
      when(mockClient.from('transactions')).thenReturn(mockQueryBuilder);
      when(mockQueryBuilder.select()).thenReturn(mockQueryBuilder);
      when(mockQueryBuilder.eq('user_id', any)).thenReturn(mockQueryBuilder);
      when(mockQueryBuilder.order('date', ascending: false)).thenReturn(mockQueryBuilder);
      when(mockQueryBuilder.execute()).thenAnswer((_) async => mockResponse);
      when(mockResponse.error).thenReturn(null);
      when(mockResponse.data).thenReturn([
        {'id': '1', 'title': 'Test', 'amount': 100.0, 'category_id': 'cat1', 'type': 'expense', 'date': '2023-01-01T00:00:00Z', 'created_at': '2023-01-01T00:00:00Z'}
      ]);

      // Act
      final result = await repository.getTransactions();

      // Assert
      expect(result, isA<List<Transaction>>());
      expect(result.length, 1);
      expect(result.first.title, 'Test');
    });
  });
}
```

### Integration Testing
```dart
void main() {
  group('Supabase Integration Tests', () {
    late SupabaseClient client;
    late SupabaseTransactionRepository repository;

    setUpAll(() async {
      // Initialize test Supabase client
      client = SupabaseClient(
        'TEST_SUPABASE_URL',
        'TEST_SUPABASE_ANON_KEY',
      );
      repository = SupabaseTransactionRepository(client);
    });

    test('should create and retrieve transaction', () async {
      // Test with actual Supabase instance
      final transaction = Transaction(
        id: '',
        title: 'Test Transaction',
        amount: 100.0,
        categoryId: 'test-category',
        type: TransactionType.expense,
        date: DateTime.now(),
        createdAt: DateTime.now(),
      );

      final created = await repository.addTransaction(transaction);
      expect(created.id, isNotEmpty);
      expect(created.title, 'Test Transaction');

      final retrieved = await repository.getTransactionById(created.id);
      expect(retrieved, isNotNull);
      expect(retrieved!.title, 'Test Transaction');
    });
  });
}
```

## Best Practices Summary

1. **Use Repository Pattern**: Encapsulate Supabase logic in repositories
2. **Handle Errors Properly**: Transform Supabase errors to app-specific exceptions
3. **Implement RLS**: Use Row Level Security for data protection
4. **Use Typed Models**: Convert JSON to strongly typed Dart objects
5. **Test Thoroughly**: Write unit and integration tests for repositories
6. **Handle Authentication**: Always check user authentication state
7. **Use Realtime Carefully**: Only subscribe to necessary data changes
8. **Optimize Queries**: Use indexes and efficient query patterns
9. **Handle Offline**: Implement proper offline/online state handling
10. **Monitor Performance**: Track query performance and optimize as needed