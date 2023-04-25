<?php echo validation_errors(); ?>
<?php echo form_open('compte/connecter'); ?>
<label>Saisissez vos identifiants ici :</label><br>
<input type="text" name="pseudo"placeholder="votre pseudo!!" />
</br>
</br>

<input type="password" name="mdp" placeholder="votre password!!" />
</br>
</br>

<input type="submit" value="Connexion"/>
</br>
</br>

</form>
