<?php echo validation_errors(); ?>
<?php echo form_open('joueur/connecter'); ?>
<label>Saisissez vos identifiants ici :</label><br>
<input type="text" name="codematch" />
<input type="text" name="userpseudo" />
<input type="submit" value="commencer"/>
</form>
