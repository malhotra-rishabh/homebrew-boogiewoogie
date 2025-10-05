# BoogieWoogie

A powerful command-line tool to manage multiple Git profiles with their corresponding SSH keys. Perfect for developers who need to switch between different Git accounts (personal, work, etc.).

## Features

- 🔄 Manage multiple Git profiles
- 🎯 Automatic Git URL rewriting based on active profile
- 🔑 Automatic SSH key management
- 🚀 Interactive profile creation
- 📝 Automatic SSH config generation with backups
- 🎨 Color-coded output
- 🔍 Current profile detection
- ⚡ Easy profile switching with connection testing
- 🗑️ Profile removal capability
- 🔒 Enhanced security features
- 💾 Automatic SSH config backups
- ✅ Connection verification after switching

## Installation

### Using Homebrew

```bash
brew tap malhotra-rishabh/boogiewoogie
brew install boogiewoogie
```

### Manual Installation

1. Download the script:
   ```bash
   curl -o ~/boogiewoogie https://raw.githubusercontent.com/malhotra-rishabh/boogiewoogie/main/boogiewoogie
   ```

2. Make it executable:
   ```bash
   chmod +x ~/boogiewoogie
   ```

3. Move to a directory in your PATH:
   ```bash
   sudo mv ~/boogiewoogie /usr/local/bin/
   ```

## Usage

### Add a New Profile

```bash
boogiewoogie add
```

This will interactively prompt you for:
- Profile name (e.g., personal, work)
- Git user name
- Git email
- Git host (e.g., github.com, gitlab.com)
- **SSH host alias** (e.g., github-personal, github-work; must be unique)
- SSH key path (optional, defaults to ~/.ssh/id_ed25519_[profile-name])

> **Note:** The SSH host alias must be unique for each profile. If you try to add a profile with an alias that already exists, BoogieWoogie will show an error and prevent the addition.

The script will:
- Save your profile
- Offer to generate a new SSH key if it doesn't exist
- Show the public key for adding to your Git host
- Suggest an alias for easy switching
- Show instructions for using the SSH alias in your Git remote URLs

### Automatic Git URL Rewriting

BoogieWoogie now automatically rewrites Git URLs to use the correct SSH host alias based on your active profile. This means you can use standard Git URLs, and they'll be automatically converted to use your profile's SSH alias.

For example, when your work profile is active:
```bash
# You can use the standard GitHub URL
git clone git@github.com:username/repo.git

# BoogieWoogie will automatically rewrite it to use your profile's alias
# It will internally use: git@github-work:username/repo.git
```

This automatic rewriting works for all Git operations (clone, push, pull, fetch, etc.) and ensures the correct SSH key is always used for your active profile.

You can also manually use the SSH alias in your remote URLs if needed:
```bash
git remote set-url origin git@github-personal:username/repo.git
# or
git remote set-url origin git@github-work:username/repo.git
```

### List All Profiles

```bash
boogiewoogie list
```

Shows all configured profiles with the current active profile marked with an asterisk (*).

### Switch Profiles

```bash
boogiewoogie switch <profile-name>
```

This will:
- Verify SSH key existence
- Update your global Git configuration
- Create a backup of your existing SSH config
- Update your SSH configuration (with all SSH aliases)
- Restart the SSH agent with the correct key
- Test connection to the Git host via the alias
- Show detailed status information, including the SSH alias to use

### Show Current Profile

```bash
boogiewoogie current
```

Displays detailed information about the currently active Git profile.

### Remove a Profile

```bash
boogiewoogie remove <profile-name>
```

Removes a profile from the configuration and updates the SSH config accordingly.

### Version Information

```bash
boogiewoogie version
```

Shows the current version of BoogieWoogie.

## Setting Up Aliases

After adding profiles, you can create aliases for quick switching. Add these to your `~/.bashrc` or `~/.zshrc`:

```bash
alias git-personal='boogiewoogie switch personal'
alias git-work='boogiewoogie switch work'
```

## Configuration Storage

- Profiles are stored in `~/.boogiewoogie/profiles.conf`
- SSH configuration is managed in `~/.ssh/config`
- SSH config backups are created automatically with timestamps
- All sensitive files are created with appropriate permissions (600)

## Example Workflow

1. Add your personal profile:
   ```bash
   boogiewoogie add
   # Enter details for personal GitHub account
   # Use SSH alias: github-personal
   ```

2. Add your work profile:
   ```bash
   boogiewoogie add
   # Enter details for work GitHub account
   # Use SSH alias: github-work
   ```

3. Switch between profiles as needed:
   ```bash
   boogiewoogie switch personal  # For personal projects
   boogiewoogie switch work      # For work projects
   ```

4. Use Git normally with standard URLs - BoogieWoogie will automatically use the correct profile:
   ```bash
   # Clone using standard GitHub URL
   git clone git@github.com:username/repo.git
   
   # The URL will be automatically rewritten to use your active profile's alias
   # For example: git@github-work:username/repo.git when work profile is active
   ```

## Security Features

- SSH keys are managed securely with appropriate permissions
- SSH configs are generated with `IdentitiesOnly yes` to prevent key leakage
- Configuration files are stored in user's home directory with restricted permissions
- Automatic backup of SSH configuration before changes
- Verification of SSH key existence before switching
- Connection testing after profile switch
- Secure handling of SSH agent operations

## Troubleshooting

If you encounter issues:

1. Check current profile and SSH alias:
   ```bash
   boogiewoogie current
   ```

2. Verify SSH key is loaded:
   ```bash
   ssh-add -l
   ```

3. Test SSH connection using the alias:
   ```bash
   ssh -T git@github-personal  # For personal GitHub
   ssh -T git@github-work      # For work GitHub
   ```

4. Check SSH config backups:
   ```bash
   ls -l ~/.ssh/config.*  # List all SSH config backups
   ```

5. Common Issues:
   - If SSH key addition fails, check key permissions (should be 600)
   - If host connection fails, verify the host key acceptance
   - If profile switch fails, ensure SSH key exists at specified path

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.