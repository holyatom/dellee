module.exports =
  errors:
    # Common errors:
    unexpected_error: 'Unexpected API error'
    validation_failed: 'Validation failed'
    not_found: 'Resource not found'
    required: '%s is required'
    bad_boolean_value: 'Expected boolean value'
    bad_int_value: 'Expected integer number'
    bad_decimal_value: 'Expected decimal number'
    less_than_allowed: '%s is less than allowed'
    more_than_allowed: '%s is more than allowed'
    shorter_than_allowed: '%s is too short'
    longer_than_allowed: '%s is too long'
    invalid_date: 'Wrong format of date'
    auth_required: 'Authorization required'
    access_denied: 'Access denied'
    invalid_value: 'Invalid value'
    already_exists: '%s has already registered'
    non_existent: '%s doesn\'t exist'

    # Custom errors, users:
    bad_email: 'Wrong e-mail address'
    bad_phone_number: 'Wrong format of phone number'
    bad_email_or_phone_number: 'Wrong format of e-mail address or phone number'
    wrong_login_or_password: 'Invalid credentials'
    unknown_user: 'Unknown e-mail address or phone number'
    invalid_username: 'Bad or reserved username'
    code_expired: 'Code has expired'

    # Custom order errors:
    empty_cart: 'Your cart is empty'
    no_delivery: 'No delivery method specified'
    order_already_processed: 'Gift is already being processed'
    card_declined: 'Credit card has been declined'
    order_expired: 'Sorry, but gift has expired'
    not_enough_bonus_points: 'You don\'t have enough fuel points'
    bonus_limit_exceeded: 'You can use fuel points to pay not more than 50% of total amount'
    unallowed_status: 'Cannot change current status to specified one'
    notifications_limit_exhausted: 'Your notifications limit is exhausted'
    already_accepted: 'Gift has been already accepted'
    out_of_stock: 'Product is out of stock'
    you_are_blocked: 'Recipient has blocked you'

    # Vouchers:
    voucher_vs_bonus_points: 'You can use either voucher or fuel points'
    voucher_not_found: 'Voucher is not found'
    voucher_disabled: 'Voucher is disabled'
    voucher_expired: 'Voucher has expired'
    voucher_already_used: 'Voucher has been already used'
    voucher_not_applicable: 'Voucher is not applicable to these products'

    # Custom admin errors:
    bad_username_or_password: 'Unknown username or wrong password'

    # Custom admin catalog errors:
    empty_product_modifications: 'Specify at least one modification'
    merge_other_merchant: 'Cannot merge products from different merchants'
    already_imported: 'Product already imported'
    cannot_create_mod_affiliate_product: 'Cannot create modification for product provided by affiliated merchant'
    only_one_increase_allowed: 'Only one value from extra_cost_percent and extra_cost_fixed can be specified'
    more_than_paid: 'Amount to refund should be less or equal than paid amount'
    mod_already_exists: 'Modification with the same attributes already exists'
    affiliated_merchant: 'Cannot create product with merchant from affiliate network'

    # Extra messages:
    alphanumeric: 'Alphanumeric symbols are allowed only'

    # Free gift
    not_enough_recipients: 'You should send free gifts at least to five your contacts to obtain your one'
    free_gift_isnt_selected: 'Please, choose your free gift to obtain it'
