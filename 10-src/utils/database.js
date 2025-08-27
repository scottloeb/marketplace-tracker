// Supabase Client Configuration
// Replace these with your actual Supabase credentials
const SUPABASE_URL = 'https://ufcjjtbyzlwtkrzyknbr.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVmY2pqdGJ5emx3dGtyenlrbmJyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYyMzc4ODksImV4cCI6MjA3MTgxMzg4OX0.iP1VSUW2i78IHgeptg0yzxPv1mesbIlxO2l7xcxie2c';

// Initialize Supabase client (will be set after library loads)
let supabaseClient = null;

// Initialize the client when Supabase library is available
function initializeSupabase() {
    if (typeof supabase !== 'undefined') {
        supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
        return true;
    }
    return false;
}

// Real-time subscription for listings
let listingsSubscription = null;

// Database operations
const DatabaseService = {
    // Check if Supabase is initialized
    isInitialized() {
        return supabaseClient !== null;
    },

    // Initialize real-time subscriptions
    initRealtimeSubscriptions() {
        if (!this.isInitialized()) {
            console.error('Supabase client not initialized');
            return false;
        }
        
        listingsSubscription = supabaseClient
            .channel('listings_changes')
            .on('postgres_changes', 
                { event: '*', schema: 'public', table: 'listings' },
                (payload) => {
                    console.log('Listing change detected:', payload);
                    this.handleListingChange(payload);
                }
            )
            .subscribe();
    },

    // Handle real-time listing changes
    handleListingChange(payload) {
        const { eventType, new: newRecord, old: oldRecord } = payload;
        
        switch (eventType) {
            case 'INSERT':
                this.addListingToUI(newRecord);
                break;
            case 'UPDATE':
                this.updateListingInUI(newRecord);
                break;
            case 'DELETE':
                this.removeListingFromUI(oldRecord.id);
                break;
        }
    },

    // Add listing to database
    async addListing(listingData) {
        if (!this.isInitialized()) {
            throw new Error('Supabase client not initialized');
        }
        
        try {
            const { data, error } = await supabaseClient
                .from('listings')
                .insert([listingData])
                .select();

            if (error) throw error;
            return data[0];
        } catch (error) {
            console.error('Error adding listing:', error);
            throw error;
        }
    },

    // Update listing in database
    async updateListing(id, updates) {
        try {
            const { data, error } = await supabaseClient
                .from('listings')
                .update(updates)
                .eq('id', id)
                .select();

            if (error) throw error;
            return data[0];
        } catch (error) {
            console.error('Error updating listing:', error);
            throw error;
        }
    },

    // Get all listings
    async getListings() {
        try {
            const { data, error } = await supabaseClient
                .from('listings')
                .select('*')
                .order('created_at', { ascending: false });

            if (error) throw error;
            return data;
        } catch (error) {
            console.error('Error fetching listings:', error);
            throw error;
        }
    },

    // Get price history for a listing
    async getPriceHistory(listingId) {
        try {
            const { data, error } = await supabaseClient
                .from('price_history')
                .select('*')
                .eq('listing_id', listingId)
                .order('recorded_at', { ascending: true });

            if (error) throw error;
            return data;
        } catch (error) {
            console.error('Error fetching price history:', error);
            throw error;
        }
    },

    // Add to enhancement queue
    async queueEnhancement(listingId, priority = 1) {
        try {
            const { data, error } = await supabaseClient
                .from('enhancement_queue')
                .insert([{
                    listing_id: listingId,
                    priority: priority
                }])
                .select();

            if (error) throw error;
            return data[0];
        } catch (error) {
            console.error('Error queuing enhancement:', error);
            throw error;
        }
    },

    // UI update methods
    addListingToUI(listing) {
        // This will be implemented in the main interface
        if (window.addListingToUI) {
            window.addListingToUI(listing);
        }
    },

    updateListingInUI(listing) {
        // This will be implemented in the main interface
        if (window.updateListingInUI) {
            window.updateListingInUI(listing);
        }
    },

    removeListingFromUI(listingId) {
        // This will be implemented in the main interface
        if (window.removeListingFromUI) {
            window.removeListingFromUI(listingId);
        }
    }
};

// Export for use in main interface
window.DatabaseService = DatabaseService;
