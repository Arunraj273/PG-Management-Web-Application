# PG Management App - Form Generation Feature Guide

## Overview
The form generation feature allows administrators to create shareable links that clients can use to submit applications for PG accommodation. This eliminates the need for manual data entry and streamlines the tenant onboarding process.

## Key Features

### 1. Form Link Generation
- **Location**: Navigate to "Form Generator" from the header menu
- **Action**: Click "Generate New Form Link" to create a unique shareable URL
- **Management**: 
  - Copy links to clipboard with one click
  - Activate/deactivate links as needed
  - View creation timestamps
  - Open forms in new tab to preview

### 2. Public Form (Client-Facing)
- **Access**: No authentication required - clients can fill the form directly
- **URL Format**: `https://your-domain.com/form/{unique-token}`
- **Form Fields**:
  - Full Name (required)
  - Preferred Floor (required, number input)
  - Current Address (required, text area)
  - Aadhar Number (required, 12 digits)
  - Phone Number (required, 10 digits)
  - Document Upload (optional, max 5MB, JPG/PNG/PDF)

### 3. Submission Management
- **Location**: Navigate to "Submissions" from the header menu
- **Dashboard Stats**:
  - Total pending applications
  - Total approved applications
  - Total rejected applications
- **Actions**:
  - View detailed information for each submission
  - Approve applications and assign rooms
  - Reject applications
  - View uploaded documents

### 4. Room Assignment
- **Smart Suggestions**: When approving an application, the system suggests:
  - Rooms on the client's preferred floor (shown first)
  - Other available rooms (shown as alternatives)
- **Availability Check**: Only rooms with available beds are shown
- **One-Click Assignment**: Approve and assign room in a single action

## Workflow

### Admin Workflow
1. **Generate Form Link**
   ```
   Dashboard → Form Generator → Generate New Form Link → Copy Link
   ```

2. **Share with Clients**
   - Send via email, WhatsApp, SMS, or any messaging platform
   - Link remains active until manually deactivated

3. **Review Submissions**
   ```
   Dashboard → Submissions → View pending applications
   ```

4. **Process Applications**
   - Click "View Details" to see complete information
   - Click "Approve" to assign a room (system suggests rooms on preferred floor)
   - Click "Reject" to decline the application

### Client Workflow
1. **Receive Link** from admin
2. **Open Link** in browser (no login required)
3. **Fill Form** with personal details
4. **Upload Document** (optional - ID proof, etc.)
5. **Submit Application**
6. **Confirmation** shown on screen

## Database Structure

### New Tables

#### form_links
- `id`: UUID (primary key)
- `token`: Unique token for the form URL
- `created_by`: Admin who created the link
- `created_at`: Timestamp
- `is_active`: Boolean (can be toggled)

#### form_submissions
- `id`: UUID (primary key)
- `form_link_id`: Reference to the form link used
- `name`: Applicant's full name
- `floor`: Preferred floor number
- `address`: Current address
- `aadhar`: Aadhar number (unique)
- `phone`: Phone number
- `file_url`: URL of uploaded document (nullable)
- `status`: 'pending' | 'approved' | 'rejected'
- `assigned_room_id`: Room assigned (nullable)
- `submitted_at`: Timestamp
- `processed_at`: Timestamp (nullable)
- `processed_by`: Admin who processed (nullable)

### Updated Tables

#### rooms
- Added `floor` field (integer, required)
- All existing rooms need floor information

## Security Features

1. **Public Access Control**
   - Form links can be deactivated to prevent new submissions
   - Inactive links show error message to clients
   - Token-based validation ensures only valid links work

2. **File Upload Security**
   - Maximum file size: 5MB
   - Allowed formats: JPG, PNG, PDF
   - Files stored in Supabase Storage with unique names
   - Public URLs generated for admin viewing

3. **Data Validation**
   - Aadhar: Exactly 12 digits
   - Phone: Exactly 10 digits
   - Floor: Positive integer
   - All required fields validated before submission

4. **Admin-Only Features**
   - Form generation restricted to admin users
   - Submission management restricted to admin users
   - Room assignment restricted to admin users

## UI Components

### Header Navigation (Admin Only)
- **Form Generator** button - Quick access to create/manage links
- **Submissions** button - Quick access to review applications
- Mobile-responsive: Buttons move to dropdown menu on small screens

### Dashboard Updates
- Room cards now display floor information
- Format: "2-Sharing • Floor 3"

### Form Generator Page
- List of all generated links
- Status badges (Active/Inactive)
- Action buttons: Copy, Open, Activate/Deactivate
- Instructions section explaining the workflow

### Submissions Page
- Statistics cards showing counts by status
- Filterable table of all submissions
- Quick actions: View, Approve, Reject
- Detailed view dialog with all information
- Room assignment dialog with smart suggestions

### Public Form Page
- Clean, professional design
- No header/footer (focused experience)
- Real-time validation
- File upload with preview
- Success confirmation screen

## API Functions

### Form Link Management
- `generateFormLink()` - Creates new form link
- `getAllFormLinks()` - Retrieves all links
- `toggleFormLinkStatus(id, isActive)` - Activate/deactivate
- `getFormLinkByToken(token)` - Validates public access

### Form Submission
- `submitForm(data)` - Handles client submission
- `getAllFormSubmissions()` - Retrieves all submissions
- `updateFormSubmissionStatus(id, status, roomId)` - Process application

### File Upload
- `uploadFile(file)` - Uploads to Supabase Storage
- Returns public URL for viewing

## Best Practices

### For Admins
1. **Generate Links Strategically**
   - Create separate links for different campaigns/sources
   - Deactivate old links when no longer needed
   - Keep track of which links are shared where

2. **Process Submissions Promptly**
   - Check submissions regularly
   - Respond to applicants quickly
   - Keep communication professional

3. **Room Assignment**
   - Prioritize preferred floor when possible
   - Check room capacity before assigning
   - Verify applicant details before approval

### For Clients
1. **Provide Accurate Information**
   - Double-check Aadhar and phone numbers
   - Provide complete address
   - Upload clear, readable documents

2. **Document Upload**
   - Use clear, high-quality scans
   - Ensure file size is under 5MB
   - Accepted formats: JPG, PNG, PDF

## Troubleshooting

### Common Issues

**Issue**: Form link shows "Invalid Link"
- **Solution**: Check if link is active in Form Generator page

**Issue**: File upload fails
- **Solution**: Ensure file is under 5MB and in JPG/PNG/PDF format

**Issue**: Cannot submit form
- **Solution**: Check all required fields are filled correctly

**Issue**: Submissions not appearing
- **Solution**: Refresh the Submissions page

## Technical Details

### Public Route Configuration
- Public form route: `/form/:token`
- Added to authentication whitelist
- No header/footer displayed on public form
- Separate layout from admin pages

### Storage Configuration
- Bucket name: `pg_management_files`
- Path structure: `uploads/{random}_{timestamp}.{ext}`
- Public access enabled for viewing
- 5MB size limit enforced

### Token Generation
- Uses PostgreSQL `gen_random_uuid()` function
- Ensures uniqueness across all form links
- Secure and unpredictable

## Future Enhancements (Optional)

1. **Email Notifications**
   - Notify admin when new submission received
   - Send confirmation email to client

2. **Form Customization**
   - Allow admins to add custom fields
   - Create multiple form templates

3. **Analytics**
   - Track form views vs submissions
   - Monitor conversion rates
   - Source tracking

4. **Bulk Operations**
   - Approve/reject multiple submissions
   - Export submissions to CSV
   - Bulk room assignments

## Support

For questions or issues:
1. Check this guide first
2. Review the TODO_FORMS.md file for implementation details
3. Check the database migration files for schema details
4. Review the API functions in src/db/api.ts

---

**Last Updated**: 2025-11-26
**Version**: 1.0.0
