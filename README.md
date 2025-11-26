# Welcome to Your Miaoda Project
Miaoda Application Link URL
    URL:https:https://app-7te7u5l37v29.appmedo.com/login

# PG Management App

A comprehensive full-stack web application for managing Paying Guest (PG) accommodations. Built with React, TypeScript, Tailwind CSS, and Supabase.

## Features

- **Room Management**: Create, edit, and delete rooms with different sharing types (2, 3, or 4-sharing)
- **Tenant Management**: Add, edit, and remove tenants with complete details
- **Occupancy Tracking**: Real-time monitoring of room occupancy and availability
- **Admin Authentication**: Secure login system with role-based access control
- **Validation**: Comprehensive validation for unique Aadhar numbers, bed assignments, and capacity limits
- **Responsive Design**: Professional UI that works seamlessly on desktop and mobile devices
- **Real-time Updates**: Instant updates across the application

##  Quick Start

### For End Users

1. **Access the Application**: Open the app in your browser
2. **Create Admin Account**: Click "Create Account" on the login page
   - First registered user automatically becomes admin
   - Use username (letters, numbers, underscores only)
   - Password must be at least 6 characters
3. **Start Managing**: Add rooms and tenants through the intuitive dashboard

📖 **See [QUICK_START.md](./docs/QUICK_START.md) for a detailed 5-minute guide**

### For Developers

#### Prerequisites

- Node.js ≥ 20
- npm ≥ 10
- Supabase account (for database)

#### Installation

```bash
# Clone the repository
git clone <repository-url>
cd app-7te7u5l37v29

# Install dependencies
npm install

# Set up environment variables
# Copy .env.example to .env and fill in your Supabase credentials
cp .env.example .env

# Start development server
npm run dev -- --host 127.0.0.1
```

#### Environment Variables

```env
VITE_SUPABASE_URL=<your-supabase-url>
VITE_SUPABASE_ANON_KEY=<your-supabase-anon-key>
VITE_APP_ID=app-7te7u5l37v29
```

##  Project Structure

```
├── src/
│   ├── components/
│   │   ├── auth/              # Authentication components
│   │   ├── common/            # Shared components (Header, Footer)
│   │   └── ui/                # shadcn/ui components
│   ├── db/
│   │   ├── supabase.ts        # Supabase client
│   │   └── api.ts             # Database API functions
│   ├── pages/
│   │   ├── Login.tsx          # Login/registration page
│   │   ├── Dashboard.tsx      # Main dashboard
│   │   ├── RoomDetails.tsx    # Room details with tenants
│   │   ├── RoomForm.tsx       # Add/edit room
│   │   └── TenantForm.tsx     # Add/edit tenant
│   ├── types/                 # TypeScript type definitions
│   ├── App.tsx                # Main app component
│   ├── routes.tsx             # Route configuration
│   └── index.css              # Global styles & design system
├── supabase/
│   └── migrations/            # Database migrations
├── docs/                      # Documentation
└── public/                    # Static assets
```

## Tech Stack

### Frontend
- **React 18** - UI framework
- **TypeScript** - Type safety
- **Tailwind CSS** - Styling
- **shadcn/ui** - Component library
- **React Router** - Navigation
- **Lucide React** - Icons

### Backend
- **Supabase** - Database & Authentication
- **PostgreSQL** - Relational database
- **Row Level Security** - Data protection

##  Database Schema

### Tables

- **profiles**: User accounts with roles (admin/user)
- **rooms**: Room information with type and capacity
- **tenants**: Tenant details with room assignments

### Key Constraints

- Unique room numbers
- Unique Aadhar numbers across all tenants
- Unique bed numbers within each room
- Automatic capacity validation

##  Authentication

- Username/password authentication
- First registered user becomes admin
- Protected routes with authentication middleware
- Session management with Supabase Auth

## 📚 Documentation

- **[QUICK_START.md](./docs/QUICK_START.md)** - Get started in 5 minutes
- **[USER_GUIDE.md](./docs/USER_GUIDE.md)** - Complete user manual
- **[IMPLEMENTATION_SUMMARY.md](./docs/IMPLEMENTATION_SUMMARY.md)** - Technical documentation

##  Development

### Available Scripts

```bash
# Start development server
npm run dev

# Build for production
npm run build

# Run linter
npm run lint

# Preview production build
npm run preview
```

### Code Quality

- ESLint for code linting
- TypeScript for type checking
- Biome for formatting
- All code passes lint checks

##  Key Features Explained

### Room Management
- Create rooms with automatic capacity assignment based on type
- Edit room details (number and type)
- Delete empty rooms (validation prevents deletion with tenants)
- Visual occupancy indicators with status badges

### Tenant Management
- Add tenants with complete information
- Validate Aadhar uniqueness across all tenants
- Validate bed number uniqueness within rooms
- Enforce room capacity limits
- Track join dates and contact information

### Validation Rules
- **Room Numbers**: Must be unique
- **Aadhar Numbers**: Must be unique (12 digits)
- **Phone Numbers**: Must be 10 digits
- **Bed Numbers**: Must be unique per room and within capacity range
- **Room Capacity**: Cannot exceed based on room type

##  Deployment

### Frontend (Vercel)
```bash
# Build command
npm run build

# Output directory
dist
```

### Backend (Supabase)
- Database migrations applied automatically
- RLS policies active
- Authentication configured

## 📝 Sample Data

The application includes sample data for demonstration:
- 3 sample rooms (101, 102, 103)
- 6 sample tenants distributed across rooms

You can delete this data through the admin interface once familiar with the system.

##  Contributing

This is a production application. For modifications:
1. Follow the existing code structure
2. Maintain TypeScript types
3. Ensure all validations work correctly
4. Test thoroughly before deployment

## 📄 License

This project is part of the Miaoda platform.

##  Support

For issues or questions:
- Check the [USER_GUIDE.md](./docs/USER_GUIDE.md)
- Review the [QUICK_START.md](./docs/QUICK_START.md)
- Contact your system administrator

##  Acknowledgments

Built with modern web technologies and best practices for a seamless user experience.

---

**Ready to manage your PG efficiently? Get started now!** 🚀
