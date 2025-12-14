// Main JavaScript file with jQuery

$(document).ready(function() {
    console.log("Help Desk System Loaded");
    
    // Auto-dismiss alerts after 5 seconds
    setTimeout(function() {
        $('.alert').fadeOut('slow');
    }, 5000);
    
    // Confirm before changing user role
    $('form[action*="user_change_role"]').on('submit', function(e) {
        const userName = $(this).closest('tr').find('td:nth-child(2)').text();
        const newRole = $(this).find('select[name="role"]').val();
        
        if (!confirm(`Are you sure you want to change ${userName}'s role to ${newRole}?`)) {
            e.preventDefault();
        }
    });
    
    // Highlight current page in navbar
    const currentPath = window.location.pathname;
    $('.navbar-nav .nav-link').each(function() {
        if ($(this).attr('href') === currentPath) {
            $(this).addClass('active fw-bold');
        }
    });
    
    // Add character counter to comment textarea
    const commentTextarea = $('#commentText');
    if (commentTextarea.length) {
        commentTextarea.after('<small class="form-text text-muted" id="charCount">0 characters</small>');
        
        commentTextarea.on('input', function() {
            const length = $(this).val().length;
            $('#charCount').text(length + ' characters');
        });
    }
    
    // Smooth scroll for alerts
    if ($('.alert').length) {
        $('html, body').animate({
            scrollTop: $('.alert').offset().top - 100
        }, 500);
    }
    
    // Add tooltips to badges
    $('[data-bs-toggle="tooltip"]').tooltip();
    
    // Table row click animation
    $('table tbody tr').on('click', function() {
        $(this).addClass('table-active');
        setTimeout(() => {
            $(this).removeClass('table-active');
        }, 300);
    });
});

// Optional: AJAX comment submission (enhancement)
function submitCommentAjax(ticketId) {
    const comment = $('#commentText').val();
    
    if (!comment.trim()) {
        alert('Comment cannot be empty!');
        return false;
    }
    
    $.ajax({
        url: `/tickets/${ticketId}/comments`,
        method: 'POST',
        data: { comment: comment },
        success: function(response) {
            location.reload(); // Reload to show new comment
        },
        error: function(xhr) {
            alert('Error adding comment. Please try again.');
        }
    });
    
    return false;
}
