extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Function to generate a PKCE code verifier
func generate_code_verifier(length: int = 64) -> String:
	assert(length >= 43 and length <= 128, "Code verifier length must be between 43 and 128")
	var charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
	var verifier = ""
	var rng = RandomNumberGenerator.new()
	rng.randomize() 
	for i in range(length):
		verifier += charset[rng.randi_range(0, charset.length() - 1)]
	return verifier

func generate_code_challenge(verifier: String) -> String:
	var sha256 = HashingContext.new()
	sha256.start(HashingContext.HASH_SHA256)
	sha256.update(verifier.to_utf8_buffer())
	var hash = sha256.finish()
	var base64_encoded = hash.to_base64().replace("+", "-").replace("/", "_").strip_suffix("=")
	return base64_encoded

func _on_texture_button_pressed() -> void:
	%Control_select.visible = false
	
	### GENERATE THE PKCE STUFF
	var code_verifier = generate_code_verifier()
	var code_challenge = generate_code_challenge(code_verifier)
	
	### PREPARE THE WEB SERVER
