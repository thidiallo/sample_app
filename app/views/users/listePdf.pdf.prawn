<table class="profile" summary="Information profil">
  <tr>
    <td>
         <strong>Nom </strong>
    </td>
    <td>
         <strong>E-mail </strong>
    </td>
    <td>
         <strong>CV </strong>
    </td>
  </tr>
  
  <% @liste.each do |l| %>
   <tr>
      <td> <%= l.nom %> </td>
      <td> <%= l.email %> </td>
      <td> <%= link_to 'print', l.attach.url %> </td>  
   </tr>  
  <% end %>
</table>

